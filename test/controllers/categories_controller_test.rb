require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @category = categories(:one)
  end

  test "should get index" do
    get categories_path, as: :json
    assert_response :success
    assert_equal(JSON.parse(@response.body).size, Category.count)
  end

  test "should show category" do
    get category_path(@category), as: :json
    assert_response :success
    assert_equal(@category.name, JSON.parse(@response.body)["name"])
  end

  test "should create a new category" do
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: { name: "New category" } }, as: :json
    end
    assert_response :created
  end

  test "should update category" do
    patch category_path(@category), params: { name: "New name for category" }, as: :json
    assert_response :success
    @category.reload
    assert_equal(@category.name, "New name for category")  
  end

  test "should destroy an article" do 
    assert_difference('Category.count', -1) do
      delete category_path(@category), as: :json
    end
    assert_response :no_content
  end

  test "should return 422 when creating article with invalid data" do
    post categories_path, params: { name: "" }, as: :json
    assert_response :unprocessable_entity
  end

  # test "should return 403 when creating article without permission" do
    
  # end

  test "should return 404 when showing non-existent article" do
    get category_path(id: 'non-existing'), as: :json
    assert_response :not_found
  end

  test "should return 422 when updating article with invalid data" do
    patch category_path(@category), params: { name: '' }, as: :json
    assert_response :unprocessable_entity
  end

  test "should return 404 when updating non-existent article" do
    patch category_path(id: 'non-existing'), params: { name: 'New name' }, as: :json
    assert_response :not_found
  end

  test "should return 404 when deleting non-existent article" do
    delete category_path(id: 'non-existing'), as: :json
    assert_response :not_found
  end
end