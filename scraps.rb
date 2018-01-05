order(created_at: :asc).all.only(:order).from(all.reverse_order.limit(10), boats)

Boat.joins(:classifications).where("classifications_count = ?", 3)


Client.first(:conditions => ["orders_count = ?", params[:orders]])

Boat.joins(:classifications).where(:conditions => ["categories_count = ?", 3])


Captain.joins(:boats).joins(:classifications).where("classifications.name = ?", "Catamarans")
