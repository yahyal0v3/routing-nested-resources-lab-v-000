class SongsController < ApplicationController
  def index
    if params[:artist_id]
      if Artist.exists?(params[:artist_id])
        @songs = Artist.find(params[:artist_id]).songs
        @song = Song.find_by(artist_id: params[:artist_id])
      else
        redirect_to artists_path, alert: "Artist not found."
      end
    else
      @songs = Song.all
    end
  end

  def show
    if Song.exists?(params[:id])
      @song = Song.find(params[:id])
      if @song.artist_id = nil
        redirect_to songs_path, alert: "Add Artist"
      end
    else
      redirect_to artist_songs_path(params[:artist_id]), alert: "Song not found."
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
