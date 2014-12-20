require 'spec_helper'

require 'generators/rom/mapper_generator'

describe ROM::Generators::MapperGenerator do
  destination File.expand_path('../../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator ['users']
  end

  specify do
    expect(destination_root).to have_structure do
      directory 'app' do
        directory 'mappers' do
          file 'users.rb' do
            contains <<-RUBY
              ROM.mappers do

                define(:users) do
                  # specify model and attributes ie
                  #
                  # model User
                  #
                  # attribute :name
                  # attribute :email
                end

              end
            RUBY
          end
        end
      end
    end
  end
end
