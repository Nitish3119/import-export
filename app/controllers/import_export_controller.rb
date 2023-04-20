class ImportExportController < ApplicationController
  def index
    @users = User.all
  end

  def import
    csv_file = params[:file]

    if csv_file.nil?
      flash[:error] = "No file selected for import."
      redirect_to import_export_import_path and return
    end

    if csv_file.content_type != "text/csv"
      flash[:error] = "Invalid file format. Please select a CSV file."
      redirect_to import_export_import_path and return
    end

    csv_data = csv_file.read

    begin
      users = []
      CSV.parse(csv_data, headers: true) do |row|
        user = User.new
        user.name = row["Name"]
        user.age = row["Age"]
        user.email = row["Email"]
        user.phone_number = row["Phone Number"]
        users << user
      end
      users.each do |user|
        user.save!
      end
      notify :success, "#{users.length} users imported successfully."
    rescue
      flash[:error] = "Error importing users. Please check your CSV file and try again."
    end

    redirect_to import_export_index_path
  end

  def export
    @users = User.all

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"users.csv\""
        headers['Content-Type'] ||= 'text/csv'

        csv_data = CSV.generate do |csv|
          csv << ["Name", "Age", "Email", "Phone Number"]

          @users.each do |user|
            csv << [user.name, user.age, user.email, user.phone_number]
          end
        end

        send_data csv_data, filename: "users.csv"
      end
    end
  end
end
