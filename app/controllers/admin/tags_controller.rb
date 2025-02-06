class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      # respond for multi-select stimulus
      render json: { record: @tag }, status: :created
    else
      render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
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
