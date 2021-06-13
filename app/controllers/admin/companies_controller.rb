module Admin
  class CompaniesController < ApplicationController
    include HasBreadcrumbs

    before_action :set_company, only: [:show, :edit, :update, :destroy]

    def index
      if policy(:user).super_admin?
        respond_to do |format|
          format.html
          format.json { render json: CompaniesDatatable.new(view_context) }
        end
      else
        redirect_to root_path, flash: { error: I18n.t('controllers.user_not_authorized') }
      end
    end

    def show
      if authorize @company
        render :show
      else
        redirect_to root_path, flash: { error: I18n.t('controllers.user_not_authorized') }
      end
    end

    def edit
      if authorize @company
        render :edit
      else
        redirect_to root_path, flash: { error: I18n.t('controllers.user_not_authorized') }
      end
    end

    def update
      authorize @company
      respond_to do |format|
        if @company.update(company_params)
          format.html do
            redirect_to admin_company_path(@company), notice: I18n.t('controllers.updated', model_name: Company.model_name.human)
          end
          format.json { render :show, status: :ok, location: @company }
        else
          format.html { render :edit }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotUnique => e
      format.html { render :edit }
      format.json { render json: e.message, status: :unprocessable_entity }
    end

    def destroy
      if authorize @company
        @company.destroy
        respond_to do |format|
          format.html { redirect_to admin_companies_path, notice: I18n.t('controllers.destroyed', model_name: Company.model_name.human) }
          format.json { head :no_content }
        end
      else
        redirect_to root_path, flash: { error: I18n.t('controllers.user_not_authorized') }
      end
    end

    private

    def set_company
      @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: I18n.t('controllers.not_found', model_name: Company.model_name.human) }
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('common.home'), root_path
      if policy(:user).super_admin?
        add_breadcrumb Company.model_name.human(count: :many), admin_companies_path
      else
        add_breadcrumb Company.model_name.human(count: 1), root_path
      end
      add_breadcrumb I18n.t("controllers.#{action_name}")
    end

    def company_params
      permit = [
        :name,
        :vat_number,
        :address_one,
        :address_two,
        :city,
        :zip_code,
        :state,
        :country,
        :email,
        :website,
        :phone
      ]
      # permit += [:nick, :paid_user_count, :paid_plan, :active] if policy(:user).super_admin?
      params.require(:company).permit(permit)
    end
  end
end
