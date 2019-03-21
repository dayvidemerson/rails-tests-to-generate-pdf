require 'csv'

namespace :pdf do
  desc "Importar Colaboradores"
  task :import_collaborator, [:file] => :environment do |t, args|
    puts "Starting"
    data = CSV.open(args[:file], headers: :first_row).map(&:to_h)
    parts = data.each_slice(100).to_a
    parts.each_with_index do |part, i|
      Collaborator.create(part)
      puts i * 100
    end
    puts "Finished"
  end
end