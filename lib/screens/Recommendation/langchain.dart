// import 'package:rxdart/rxdart.dart';

// // Service to interact with your LLM service (e.g., OpenAI API)
// Future<String> queryLLM(String prompt) async {
//   // Implement logic to call your LLM service with the prompt
//   // ...
// }

// // Stream to process and parse LLM response
// Stream<List<Map<String, String>>> parseResponse(String response) {
//   // Implement logic to parse the LLM response based on expected format
//   // You can use regular expressions or other parsing libraries
//   // ...
// }

// Future<List<Map<String, String>>> getCountries() async {
//   final prompt = "List 5 countries.";

//   // Define the Zod schema for desired output format
//   final schema = z.array(z.object({
//     "fields": z.object({
//       "Name": z.string(),
//       "Capital": z.string(),
//     }),
//   })).describe("An array of country objects");

//   // Stream of LLM response
//   final responseStream = Stream.fromFuture(queryLLM(prompt));

//   // Stream of parsed data
//   final parsedStream = responseStream.asyncMap(parseResponse);

//   // Get the first element from the parsed stream (waiting for the data)
//   final countries = await parsedStream.first;

//   // Validate the parsed data against the Zod schema (optional)
//   schema.safeParse(countries);

//   return countries;
// }
