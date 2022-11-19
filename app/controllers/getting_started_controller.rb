class GettingStartedController < DashboardController
  include Wicked::Wizard
  steps :product, :user_roles, :north_stars, :features

  before_action :set_product, except: [:index]

  def show
    render_wizard
  end

  def update
    @product.update(product_params)

    # https://github.com/zombocom/wicked/pull/267#issuecomment-863328072
    options = {}
    options[:status] = :unprocessable_entity if @product.invalid?

    render_wizard @product, options, {product_id: @product.id}
  end

  private

  def product_params
    params.dig(:product)&.permit(
      :name,
      :description,
      user_roles_attributes: [
        :id,
        :name,
        :_destroy
      ],
      metrics_attributes: [
        :id,
        :name,
        :unit_of_measurement,
        :timeframe,
        :_destroy
      ]
    ) || {}
  end

  def set_product
    @product = if step == :product && params[:product_id].nil?
      Product.new
    else
      Product.find(params[:product_id])
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path
  end
end
