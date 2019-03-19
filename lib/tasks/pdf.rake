require 'csv'

namespace :pdf do
  desc "Importar Colaboradores"
  task :import_collaborator, [:file] => :environment do |t, args|
    puts "Starting"
    data = CSV.open(args[:file], headers: :first_row).map(&:to_h)
    Collaborator.create(data)
    puts "Finished"
  end
end