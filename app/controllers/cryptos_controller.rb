require 'open-uri'
require 'nokogiri'

class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[ show edit update destroy ]
  before_action :correct_user, only: %i[ show edit update destroy ]

# GET /cryptos or /cryptos.json

  def index
    @cryptos = Crypto.all
    @avatars = ["https://mdbootstrap.com/img/new/avatars/1.jpg",
                "https://mdbootstrap.com/img/new/avatars/2.jpg",
                "https://mdbootstrap.com/img/new/avatars/3.jpg",
                "https://mdbootstrap.com/img/new/avatars/4.jpg",
                "https://mdbootstrap.com/img/new/avatars/5.jpg",
                "https://mdbootstrap.com/img/new/avatars/6.jpg",
                "https://mdbootstrap.com/img/new/avatars/7.jpg",
                "https://mdbootstrap.com/img/new/avatars/8.jpg",
                "https://mdbootstrap.com/img/new/avatars/9.jpg",
                "https://mdbootstrap.com/img/new/avatars/10.jpg"].sample


    url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{ENV['API_KEY']}"
    #url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=9da0f106-d8b3-4138-865c-09975e3c1f58"
    uri = URI.open(url).read
    @tickers = JSON.parse(uri)

    @symbol = params[:query]
    if @symbol
      @symbol = @symbol.upcase
    end
  end

  # GET /cryptos/1 or /cryptos/1.json
  def show
  end

  # GET /cryptos/new
  def new
    @crypto = Crypto.new
  end

  # GET /cryptos/1/edit
  def edit
  end

  # POST /cryptos or /cryptos.json
  def create
    @crypto = Crypto.new(crypto_params)

    respond_to do |format|
      if @crypto.save
        format.html { redirect_to crypto_url(@crypto), notice: "Crypto was successfully created." }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptos/1 or /cryptos/1.json
  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to crypto_url(@crypto), notice: "Crypto was successfully updated." }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptos/1 or /cryptos/1.json
  def destroy
    @crypto.destroy

    respond_to do |format|
      format.html { redirect_to cryptos_url, notice: "Crypto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crypto_params
      params.require(:crypto).permit(:name, :symbol, :user_id, :cost_per, :amount_owned)
    end

    def correct_user
      @correct = current_user.cryptos.find_by(id: params[:id])
      redirect_to cryptos_path, notice: "Not Authorized to edit this entry!" if @correct.nil?
    end
end
