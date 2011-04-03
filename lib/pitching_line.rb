
class PitchingLine
  
  attr_accessor :line_id,:game_id, :pitcher_id, :name, :pos, :outs, :bf, :er, :r, :h, :so, :hr, :bb, :w, :l, :era, :note
  
  
  def init_from_db(line_id, db)
    res = db.get_pitcher_line(line_id)
    if res.num_rows > 0
      res.each do |row|
        @line_id = row[0]
        @game_id = row[1]
        @pitcher_id = row[2]
        @outs = row[3]
        @er = row[4]
        @r = row[5]
        @h = row[6]
        @so = row[7]
        @hr = row[8]
        @bb = row[9]
        @w = row[10]
        @l = row[11]
        @era = row[12]
        @note = row[13]
      end 
    end
  end
  
end
