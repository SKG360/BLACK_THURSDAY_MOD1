#require_relative 'find_module'
#
#module Revenue
#  include FindObjects
#
#
#
#  #def find_all_except_returned_invoices
#  #  find_all_successful_transactions_invoices.find_all do |invoice|
#  #    invoice.status != :returned
#  #  end
#  #end
#
#  def group_invoices_by_merchants
#    find_all_successful_transactions_invoices.group_by do |invoice|
#      invoice.merchant_id
#    end
#  end
#
#  def find_all_invoice_ids_for_grouped_merchants
#    group_invoices_by_merchants.keys.reduce(Hash.new(0)) do |hash, merchant_id|
#      invoice_ids = group_invoices_by_merchants[merchant_id].map do |invoice|
#        invoice.id
#      end
#      hash[merchant_id] = invoice_ids
#      hash
#    end
#  end
#
#  def finds_grouped_invoice_items
#    find_all_invoice_ids_for_grouped_merchants.reduce(Hash.new(0)) do |hash, (merchant_id, invoice_ids)|
#      invoice_items = invoice_ids.map do |invoice_id|
#        @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
#      end.flatten
#      hash[merchant_id] = invoice_items
#      hash
#    end
#  end
#
#  def finds_invoice_totals
#    finds_grouped_invoice_items.reduce(Hash.new(0)) do |hash, (merchant_id, invoice_items)|
#      totals = invoice_items.map do |invoice_item|
#        invoice_item.unit_price * invoice_item.quantity
#      end
#      hash[merchant_id] = totals
#      hash
#    end
#  end
#
#  def finds_pre_sorted_sums
#    finds_invoice_totals.reduce(Hash.new(0)) do |hash, (merchant_id, totals)|
#      hash[merchant_id] = sum_of_collection(totals)
#      hash
#    end
#  end
#
#  def sorted_merchants_by_revenue_totals
#    finds_pre_sorted_sums.sort_by do |merchant_id, grand_totals|
#      grand_totals
#    end.to_h
#  end
#end
#
