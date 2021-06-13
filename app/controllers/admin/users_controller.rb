module Admin
  class UsersController < ApplicationController
    include HasBreadcrumbs

    before_action :authenticate_user!
    before_action :allow_without_password, only: [:update]
    before_action :check_policy!
    before_action :set_user, only: [:show, :edit, :update, :destroy, :set_company]

    # GET /users
    # GET /users.json
    def index
      respond_to do |format|
        format.html
        format.json { render json: UsersDatatable.new(view_context) }
      end
    end

    # GET /users/1
    # GET /users/1.json
    def show; end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit; end

    # POST /users
    # POST /users.json
    def create
      @user = current_company.users.new(user_params)
      respond_to do |format|
        if @user.save
          # format.html { redirect_to admin_user_path(@user), notice: I18n.t('controllers.created', model_name: User.model_name.human) }
          format.js
        else
          # format.html { render :new }
          format.js { render :errors }
        end
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          # format.html { redirect_to admin_user_path(@user), notice: I18n.t('controllers.updated', model_name: User.model_name.human) }
          format.js
        else
          # format.html { render :edit }
          format.js { render :errors }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy unless @user.id == current_user.id
      respond_to do |format|
        if @user.destroyed?
          # format.html { redirect_to admin_users_path, notice: I18n.t('controllers.destroyed', model_name: User.model_name.human) }
          format.js
        else
          # format.html { redirect_to admin_users_path, error: I18n.t('errors.messages.cannot_delete_current_user') }
          format.js { render :errors }
        end
      end
    end

    def set_company
      authorize @user
      if @user.update(company_id: params['current_company'])
        redirect_to admin_company_path(params['current_company']), notice: 'Changed current company to super admin user'
      else
        redirect_to admin_companies_path, flash: { error: 'Failed to set current company for admin purposes' }
      end
    end

    private

    def allow_without_password
      return unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?

      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    def check_policy!
      authorize :user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_company.users.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_users_path, flash: { error: I18n.t('controllers.not_found', model_name: User.model_name.human) }
    end

    def set_breadcrumbs
      add_breadcrumbs [
        [t('common.home'), root_path],
        [User.model_name.human(count: :many), admin_users_path],
        [I18n.t("controllers.#{action_name}")]
      ]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :username,
        :name,
        :password,
        :password_confirmation,
        :email,
        :role,
        :phone,
        :dark_theme,
        :comment
      )
    end
  end
end
