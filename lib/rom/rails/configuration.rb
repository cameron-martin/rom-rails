module ROM
  module Rails
    class Configuration
      attr_reader :config, :setup, :env

      def self.map_adapter_name(config_hash)
        mapping = Hash.new { |_, key| key }
        mapping.merge!({ 'postgresql' => 'postgres' })

        config_hash.dup.tap do |config_hash|
          config_hash[:adapter] = mapping[config_hash[:adapter]]
        end
      end

      def self.build(app)
        config = app.config.database_configuration[::Rails.env].
          symbolize_keys.update(root: app.config.root)

        config = map_adapter_name(config)

        new(ROM::Config.build(config))
      end

      def initialize(config)
        @config = config
      end

      def setup!
        @setup = ROM.setup(@config.symbolize_keys)
      end

      def load!
        Railtie.load_all
      end

      def finalize!
        # rescuing fixes the chicken-egg problem where we have a relation
        # defined but the table doesn't exist yet
        @env = ROM.finalize.env
      rescue Registry::ElementNotFoundError => e
        warn "Skipping ROM setup => #{e.message}"
      end
    end
  end
end
