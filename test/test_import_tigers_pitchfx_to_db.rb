$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'db_importer'

importer = Gameday::DbImporter.new('localhost', 'root', '', 'pitchfx')

#importer.import_for_month('2010', '04')

importer.import_team_for_month('det', '2010', '04')

#importer.import_for_game('2009_09_09_detmlb_kcamlb_1')
