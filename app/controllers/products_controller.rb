class ProductsController < DashboardController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @pagy, @products = pagy(Product.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @products
  end

  def show
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    # Uncomment to authorize with Pundit
    # authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @product
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:account_id, :name, :description)

    # Uncomment to use Pundit permitted attributes
    # params.require(:product).permit(policy(@product).permitted_attributes)
  end
end
