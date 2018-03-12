class ReadLatersController < ApplicationController
  def index
    @read_laters = ReadLater.all
  end

  def push
    @read_later = ReadLater.create!(read_laters_params)
  end

  def pop
    @read_later = ReadLater.pop!

    render json: @read_later
  end

  def bulk_push
  end

  private

  def read_laters_params
    params.require(:read_laters).permit(:url)
  end
end
