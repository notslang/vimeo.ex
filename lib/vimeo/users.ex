defmodule Vimeo.Users do
  @moduledoc """
  Provides access to the `/users` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  # Informations --------------------------------------------------------------

  @doc """
  Search for users.
  """
  def search(params \\ %{}) do
    "users"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  @doc """
  Get a user.
  """
  def info(user_id) do
    "users/#{user_id}"
    |> API.get
    |> Parser.parse(:user)
  end

  @doc """
  Edit a single user.
  """
  def update(user_id, params) do
    "users/#{user_id}"
    |> API.patch(params)
    |> Parser.parse(:user)
  end

  # Albums --------------------------------------------------------------------

  @doc """
  Get a list of a user's Albums.
  """
  def albums(user_id, params \\ %{}) do
    "users/#{user_id}/albums"
    |> API.get(params)
    |> Parser.parse(:album)
  end

  @doc """
  Create an Album.
  """
  def create_album(user_id, params) do
    "users/#{user_id}/albums"
    |> API.post(params)
    |> Parser.parse(:album)
  end

  @doc """
  Get info on an Album.
  """
  def album(user_id, album_id) do
    "users/#{user_id}/albums/#{album_id}"
    |> API.get
    |> Parser.parse(:album)
  end

  @doc """
  Edit an Album.
  """
  def update_album(user_id, album_id, params) do
    "users/#{user_id}/albums/#{album_id}"
    |> API.patch(params)
    |> Parser.parse(:album)
  end

  @doc """
  Delete an Album.
  """
  def delete_album(user_id, album_id) do
    "users/#{user_id}/albums/#{album_id}"
    |> API.delete
    |> Parser.parse
  end

  @doc """
  Get the list of videos in an Album.
  """
  def album_videos(user_id, album_id) do
    # TODO: the sort param should be configurable here. this is an ugly hack to make another project work
    "users/#{user_id}/albums/#{album_id}/videos?sort=default"
    |> API.get()
    |> Parser.parse(:video)
  end

  @doc """
  Check if an Album contains a video.
  """
  def album_video?(user_id, album_id, video_id) do
    case API.get("users/#{user_id}/albums/#{album_id}/videos/#{video_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Add a video to an Album.
  """
  def add_album_video(user_id, album_id, video_id) do
    "users/#{user_id}/albums/#{album_id}/videos/#{video_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Remove a video from an Album.
  """
  def remove_album_video(user_id, album_id, video_id) do
    "users/#{user_id}/albums/#{album_id}/videos/#{video_id}"
    |> API.delete
    |> Parser.parse
  end

  # Appearances ---------------------------------------------------------------

  @doc """
  Get all videos that a user appears in.
  """
  def appearances(user_id, params \\ %{}) do
    "users/#{user_id}/appearances"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  # Channels ------------------------------------------------------------------

  @doc """
  Get a list of the Channels a user follows.
  """
  def channels(user_id, params \\ %{}) do
    "users/#{user_id}/channels"
    |> API.get(params)
    |> Parser.parse(:channel)
  end

  @doc """
  Check if a user follows a Channel.
  """
  def channel?(user_id, channel_id) do
    case API.get("users/#{user_id}/channels/#{channel_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Subscribe to a Channel.
  """
  def subscribe_channel(user_id, channel_id) do
    "users/#{user_id}/channels/#{channel_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unsubscribe from a Channel.
  """
  def unsubscribe_channel(user_id, channel_id) do
    "users/#{user_id}/channels/#{channel_id}"
    |> API.delete
    |> Parser.parse
  end

  # Groups --------------------------------------------------------------------

  @doc """
  Get a list of the Groups a user has joined.
  """
  def groups(user_id, params \\ %{}) do
    "users/#{user_id}/groups"
    |> API.get(params)
    |> Parser.parse(:group)
  end

  @doc """
  Check if a user joined a Group.
  """
  def group?(user_id, group_id) do
    case API.get("users/#{user_id}/groups/#{group_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Join a Group.
  """
  def join_group(user_id, group_id) do
    "users/#{user_id}/groups/#{group_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Leave a Group.
  """
  def leave_group(user_id, group_id) do
    "users/#{user_id}/groups/#{group_id}"
    |> API.delete
    |> Parser.parse
  end

  # Feed ----------------------------------------------------------------------

  @doc """
  Get a list of the videos in a user feed.
  """
  def feed(user_id, params \\ %{}) do
    "users/#{user_id}/feed"
    |> API.get(params)
    |> Parser.parse(:feed)
  end

  # Followers -----------------------------------------------------------------

  @doc """
  Get a list of the user's followers.
  """
  def followers(user_id, params \\ %{}) do
    "users/#{user_id}/followers"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  # Following -----------------------------------------------------------------

  @doc """
  Get a list of the users that a user is following.
  """
  def following(user_id, params \\ %{}) do
    "users/#{user_id}/following"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  @doc """
  Check if a user follows another user.
  """
  def following?(user_id, follow_user_id) do
    case API.get("users/#{user_id}/following/#{follow_user_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Follow a user.
  """
  def follow(user_id, follow_user_id) do
    "users/#{user_id}/following/#{follow_user_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unfollow a user.
  """
  def unfollow(user_id, follow_user_id) do
    "users/#{user_id}/following/#{follow_user_id}"
    |> API.delete
    |> Parser.parse
  end

  # Likes ---------------------------------------------------------------------

  @doc """
  Get a list of videos that a user likes.
  """
  def likes(user_id, params \\ %{}) do
    "users/#{user_id}/likes"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  @doc """
  Check if a user likes a video.
  """
  def like?(user_id, video_id) do
    case API.get("users/#{user_id}/likes/#{video_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Like a video.
  """
  def like(user_id, video_id) do
    "users/#{user_id}/likes/#{video_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unlike a video.
  """
  def unlike(user_id, video_id) do
    "users/#{user_id}/likes/#{video_id}"
    |> API.delete
    |> Parser.parse
  end

  # Pictures ------------------------------------------------------------------

  @doc """
  Get a list of this user's portrait images.
  """
  def pictures(user_id) do
    "users/#{user_id}/pictures"
    |> API.get
    |> Parser.parse(:picture)
  end

  # @doc """
  # Create a new picture resource.
  # """
  # def create_picture(data) do
  # end

  @doc """
  Check if a user has a portrait.
  """
  def picture?(user_id, picture_id) do
    case API.get("users/#{user_id}/pictures/#{picture_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Edit a portrait.
  """
  def update_picture(user_id, picture_id, params \\ %{}) do
    "users/#{user_id}/pictures/#{picture_id}"
    |> API.patch(params)
    |> Parser.parse(:picture)
  end

  @doc """
  Remove a portrait from your portrait list.
  """
  def delete_picture(user_id, picture_id) do
    "users/#{user_id}/pictures/#{picture_id}"
    |> API.delete
    |> Parser.parse
  end

  # Videos --------------------------------------------------------------------

  @doc """
  Get a list of videos uploaded by a user.
  """
  def videos(user_id, params \\ %{}) do
    "users/#{user_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  # @doc """
  # Begin the video upload process.
  # """
  # def upload_video(data, params \\ %{}) do
  # end

  @doc """
  Check if a user owns a clip.
  """
  def video?(user_id, video_id) do
    case API.get("users/#{user_id}/videos/#{video_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
end
