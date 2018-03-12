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
    markdown_listed_url_matcher = Regexp.new('\(?(http.+)\).?')

    urls =
      read_laters_params[:url].lines
      .map(&:chomp)
      .map { |url| markdown_listed_url_matcher.match(url)&.captures&.first }
      .compact

    ReadLater.transaction do
      urls.each do |url|
        ReadLater.create!(url: url)
      end
    end

    redirect_to read_laters_path
  end

  private

  def read_laters_params
    params.require(:read_laters).permit(:url)
  end
end
