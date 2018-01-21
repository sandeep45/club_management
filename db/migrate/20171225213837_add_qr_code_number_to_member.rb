class AddQrCodeNumberToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :qr_code_number, :integer
  end
end
