/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Results : Codable {
	let category : String?
	let type : String?
	let difficulty : String?
	let question : String?
	let correct_answer : String?
	let incorrect_answers : [String]?

	enum CodingKeys: String, CodingKey {

		case category = "category"
		case type = "type"
		case difficulty = "difficulty"
		case question = "question"
		case correct_answer = "correct_answer"
		case incorrect_answers = "incorrect_answers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
		question = try values.decodeIfPresent(String.self, forKey: .question)
		correct_answer = try values.decodeIfPresent(String.self, forKey: .correct_answer)
		incorrect_answers = try values.decodeIfPresent([String].self, forKey: .incorrect_answers)
	}

}