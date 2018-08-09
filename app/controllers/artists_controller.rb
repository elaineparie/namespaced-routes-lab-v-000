class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    if !Preference.all.first.empty? && Preference.all.first.artist_sort_order == "ASC"
      @artists = @artists.order('name ASC')
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    if Preference.all.first.allow_create_artists
    @artist = Artist.new
  else
    redirect_to artists_path
  end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
