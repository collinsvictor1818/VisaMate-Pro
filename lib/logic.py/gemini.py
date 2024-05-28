def recommend_travel_visa():
  user_info = GetUserInput()
  visa_options = GetVisaOptions(user_info)
  filtered_visas = FilterVisas(visa_options, user_info)
  recommendation = RecommendVisa(filtered_visas)
  visa_details = GetVisaDetails(recommendation["visa"], recommendation["country"])
  return recommendation, visa_details

# Example Usage
recommendation, visa_details = recommend_travel_visa()
print(f"Recommended Visa: {recommendation['visa']} for {recommendation['country']}")
print(f"Visa Application Details: {visa_details}")
