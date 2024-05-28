// import 'package:langchain_flutter/langchain_flutter.dart';

// // Assuming you have your API key stored securely
// const String apiKey = "...";

// Future<List<Map<String, String>>> getCountries() async {
//   // Initialize LangChain client with your API key
//   final langchainClient = LangChainClient(apiKey: apiKey);

//   // Define the LLM model and prompt
//   final model = LLModel.openAI(modelName: "gpt-4");
//   final prompt = PromptTemplate(
//       template:
//           "Answer the user's question as best you can:\n{format_instructions}\n{query}",
//       inputVariables: ["query"],
//       partialVariables: {
//         "format_instructions":
//             outputFixingParser.getFormatInstructions() // Assuming an outputFixingParser is available
//       });

//   // Define the desired output format using Zod schema
//   final schema = z.array(z.object({
//     "fields": z.object({
//       "Name": z.string(),
//       "Capital": z.string(),
//     }),
//   })).describe("An array of country objects");

//   final outputParser = StructuredOutputParser.fromZodSchema(schema);

//   // Create the LLM chain with output fixing parser
//   final chain = LLMChain(
//       llm: model,
//       prompt: prompt,
//       outputKey: "records",
//       outputParser: outputFixingParser);

//   // Call the LLM chain with the query
//   final result = await chain.call(query: "List 5 countries.");

//   // Cast the result to a list of maps
//   return result.records.cast<Map<String, String>>();
// }
