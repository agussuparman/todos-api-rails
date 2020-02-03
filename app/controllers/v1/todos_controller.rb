module V1
	class TodosController < ApplicationController
		before_action :set_todo, only: [:show, :update, :destroy]

		# GET /todos
		def index
			# @todos = Todo.all
			# Mendapatkan user todos saat ini
			@todos = current_user.todos.paginate(per_page: 20, page: params[:page])
			json_response(@todos)
		end

		# POST /todos
		def create
			# Membuat todos yang dimiliki user saat ini
			# @todo = Todo.create!(todo_params)
			@todo = current_user.todos.create!(todo_params)
			json_response(@todo, :created)
		end

		# GET /todos/:id
		def show
			json_response(@todo)
		end

		# PUT /todos/:id
		def update
			@todo.update(todo_params)
			head :no_content
		end

		# DELETE /todos/:id
		def destroy
			@todo.destroy
			head :no_content
		end

		private

		def todo_params
			params.permit(:title)
		end

		def set_todo
			@todo = Todo.find(params[:id])
		end
	end
end