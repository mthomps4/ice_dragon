class Admin::TagsController < AdminController
  def index
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to admin_tags_path, notice: "Tag created successfully" }
        format.json { render json: { record: @tag }, status: :created }
      else
        format.html { redirect_to admin_tags_path, alert: "Tag creation failed", status: :unprocessable_entity }
        format.json { render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to admin_tags_path, notice: "Tag deleted successfully" }
      format.json { head :no_content }
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
