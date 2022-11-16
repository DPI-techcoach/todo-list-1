class ListsController < ApplicationController
  def index
    matching_lists = List.all

    @list_of_lists = matching_lists.order({ :created_at => :desc })

    the_id = session[:user_id]

    @the_list = List.where({ :user_id => the_id, :status  => "next up"  })

    @the_list_in_progress = List.where({ :user_id => the_id, :status  => "in_progress"  })

    @the_list_done = List.where({ :user_id => the_id, :status  => "done"  })

    if session.fetch(:user_id) != nil
      render({ :template => "lists/index.html.erb" })
  else 
    redirect_to("/")
  end

  end

  def show
    the_id = params.fetch("path_id")

    matching_lists = List.where({ :id => the_id })

    @the_list = matching_lists.at(0)

    render({ :template => "lists/show.html.erb" })
  end

  def create
    the_list = List.new
    the_list.status = "next up"
    the_list.description = params.fetch("query_description")
    the_list.user_id = session[:user_id]

    if the_list.valid?
      the_list.save
      redirect_to("/lists", { :notice => "List created successfully." })
    else
      redirect_to("/lists", { :alert => the_list.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_list = List.where({ :id => the_id }).at(0)

    the_list.status = params.fetch("query_status")
    # the_list.description = params.fetch("query_description")
    # the_list.user_id = params.fetch("query_user_id")

    if the_list.valid?
      the_list.save
      redirect_to("/lists", { :notice => "List updated successfully."} )
    # else
    #   redirect_to("/lists/#{the_list.id}", { :alert => the_list.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_list = List.where({ :id => the_id }).at(0)

    the_list.destroy

    redirect_to("/lists", { :notice => "List deleted successfully."} )
  end
end
