from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import joblib
from fastapi.responses import JSONResponse

# ✅ Load the trained model
try:
    xgb_model = joblib.load("health_nutrition_model.pkl")  # Adjust filename if needed
    print("✅ Model loaded successfully.")
except Exception as e:
    print(f"❌ Failed to load model: {e}")

# ✅ Define input data structure
class NutritionData(BaseModel):
    Calories: int
    Protein: float
    Carbohydrates: float
    Fat: float
    Fiber: float
    Sugars: float
    Sodium: int
    Cholesterol: int
    Water_Intake: int
    Meal_Type_Dinner: bool
    Meal_Type_Lunch: bool
    Meal_Type_Snack: bool
    Category_Dairy: bool
    Category_Fruits: bool
    Category_Grains: bool
    Category_Meat: bool
    Category_Snacks: bool
    Category_Vegetables: bool

# ✅ Create FastAPI app
app = FastAPI()

# ✅ Health risk analysis
def health_risks(nutrition):
    risks = []
    if nutrition['Fat'] > 20:
        risks.append("High Fat: Not suitable for heart patients.")
    if nutrition['Sodium'] > 500:
        risks.append("High Sodium: Risk of hypertension.")
    if nutrition['Sugars'] > 25:
        risks.append("High Sugar: Risk for diabetes.")
    if nutrition['Fiber'] < 2 and nutrition['Fat'] > 15:
        risks.append("Low Fiber + High Fat: Digestive risks.")
    return risks

@app.post("/predict")
def predict(data: NutritionData):
    try:
        # ✅ Map data to match model columns
        mapped_data = {
            'Calories (kcal)': data.Calories,
            'Protein (g)': data.Protein,
            'Carbohydrates (g)': data.Carbohydrates,
            'Fat (g)': data.Fat,
            'Fiber (g)': data.Fiber,
            'Sugars (g)': data.Sugars,
            'Sodium (mg)': data.Sodium,
            'Cholesterol (mg)': data.Cholesterol,
            'Water_Intake (ml)': data.Water_Intake,
            'Meal_Type_Dinner': data.Meal_Type_Dinner,
            'Meal_Type_Lunch': data.Meal_Type_Lunch,
            'Meal_Type_Snack': data.Meal_Type_Snack,
            'Category_Dairy': data.Category_Dairy,
            'Category_Fruits': data.Category_Fruits,
            'Category_Grains': data.Category_Grains,
            'Category_Meat': data.Category_Meat,
            'Category_Snacks': data.Category_Snacks,
            'Category_Vegetables': data.Category_Vegetables,
        }

        input_data = pd.DataFrame([mapped_data])
        print("✅ Input DataFrame columns:", input_data.columns.tolist())

        # ✅ Predict
        prediction = xgb_model.predict(input_data)[0]
        print("✅ Raw prediction:", prediction)

        # ✅ Correct Mapping: 0 → Healthy, 1 → Unhealthy
        prediction_label = "Healthy" if prediction == 0 else "Unhealthy"

        # ✅ Health risks
        risks = health_risks(data.dict())

        # ✅ Final result
        result = {
            "Prediction": prediction_label,
            "Health Risks": risks
        }
        return result

    except Exception as e:
        print(f"❌ Prediction failed: {e}")
        return JSONResponse(
            status_code=500,
            content={"error": f"Internal Server Error: {e}"}
        )

@app.get("/")
def read_root():
    return {"message": "NutriScan API is running!"}
