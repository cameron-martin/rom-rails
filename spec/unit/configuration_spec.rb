require 'spec_helper'

describe ROM::Rails::Configuration do
  describe '.map_adapter_name' do
    it 'maps postgresql -> postgres' do
      old_config = {:adapter=>"postgresql", :encoding=>"unicode", :database=>"leaguejobs"}
      new_config = ROM::Rails::Configuration.map_adapter_name(old_config)

      expect(new_config).to eq({:adapter=>"postgres", :encoding=>"unicode", :database=>"leaguejobs"} )
    end

    it 'leaves other adapters alone' do
      old_config = {:adapter=>"sqlite", :encoding=>"unicode", :database=>"leaguejobs"}
      new_config = ROM::Rails::Configuration.map_adapter_name(old_config)

      expect(new_config).to eq({:adapter=>"sqlite", :encoding=>"unicode", :database=>"leaguejobs"} )
    end
  end
end