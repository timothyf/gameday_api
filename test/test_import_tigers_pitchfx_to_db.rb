$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'db_importer'

importer = DbImporter.new('localhost', 'root', '', 'pitchfx')

#importer.import_for_month(year, month)

importer.import_for_game('2009_09_09_detmlb_kcamlb_1')
