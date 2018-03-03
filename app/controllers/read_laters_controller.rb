class ReadLatersController < ApplicationController
  def index
    @read_laters = ReadLater.all
  end

  def push
    @read_later = ReadLater.create!(read_laters_params)
  end

  private

  def read_laters_params
    params.require(:read_laters).permit(:url)
  end
end
