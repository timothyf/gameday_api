require_realtive 'db_importer'

db = DbImporter.new('localhost','root','','pitchfx')

#db.import_for_month('2010','04')

db.import_for_date('2010','04', '05')

