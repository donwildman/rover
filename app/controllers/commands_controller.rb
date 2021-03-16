class CommandsController < ApplicationController

    DIRECTIONS = 'NSEW'
    COMMANDS = 'LRM'


    def index
        @X = 0
        @Y = 0
        @direction = 'N'
        @commands = {
            :x => @X,
            :y => @Y,
            :direction => @direction,
            :error => nil
        }
        @rover_count = ENV['ROVER_COUNT'].to_i
    end

    def do_command(c)
      if (c == 'L')
        if (@direction == 'N')
          change_direction('W')
        elsif (@direction == 'W')
          change_direction('S')
        elsif (@direction == 'S')
          change_direction('E')
        elsif (@direction == 'E')
          change_direction('N')
        end
      else
        if (c == 'R')
          if (@direction == 'N')
            change_direction('E')
          elsif (@direction == 'E')
            change_direction('S')
          elsif (@direction == 'S')
            change_direction('W')
          elsif (@direction == 'W')
            change_direction('N')
          end
        elsif (c == 'M')
          do_move
        end
      end
    end

    def do_move
      if (@direction == 'N')
        @Y = @Y + 1
      elsif (@direction == 'E')
        @X = @X + 1
      elsif (@direction == 'S')
        @Y = @Y - 1
      elsif (@direction == 'W')
        @X = @X - 1
      end
    end

  def change_direction(d)
    @direction = ( DIRECTIONS.index(d)) ? d : @direction
  end



  def parse_input(c)
    multi = c.split(//)
    multi.length.times do |i|
      _c = multi[i]
      if COMMANDS.index(_c)
        do_command(_c)
      end
    end
  end
  
  
  def show
    @rover_id = params[:rover_id].to_i
    @X = params[:X].to_i
    @Y = params[:Y].to_i
    @direction = params[:direction]
    cmd = params[:command]

    unless cmd.nil?
      parse_input(cmd)
    end

    if @X < 0 || @Y < 0
      @commands = {:x => params[:X],:y => params[:Y],:direction => @direction, :error => "Out of bounds!"}
    else
      @commands = {:x => @X,:y => @Y,:direction => @direction, :error => nil}
    end


  end
end
