class HomeController < ApplicationController
  def index
    @shipments = Shipment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipments }
    end
  end
end
