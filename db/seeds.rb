	# This file should contain all the record creation needed to seed the database with its default values.
	# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
	#
	# Examples:
	#
	#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
	#   Character.create(name: 'Luke', movie: movies.first)
	puts "destroy all"
	Product.destroy_all
	Protocol.destroy_all
	Testsuite.destroy_all
	CaseResult.destroy_all
	Testcase.destroy_all
	Documentation.destroy_all
	UserTesting.destroy_all
	User.destroy_all
	TestTagging.destroy_all
	Tag.destroy_all
	KeywordTesting.destroy_all
	Keyword.destroy_all


	puts "create users"

	user_1 = User.create!(name: "Nidaa",
											password: "123456",
											email: "abc@com")
	user_2 = User.create!(name: "user_2",
											password: "789012",
											email: "def@com")

	puts "create keywords"

	kw_1 = Keyword.create!(body: "keyword_1")
	kw_2 = Keyword.create!(body: "keyword_2")

	puts "create tags"

	tag_1 = Tag.create!(name: "MKS#123")
	tag_2 = Tag.create!(name: "MKS#154")

	puts "create a product"
	5.times do |i|

		product = Product.create!(name: "Product_#{i}",
															dhf_num: "v#{i}")

		product.save!

		puts "create protocols"
		3.times do |j|
			protocol = product.protocols.create!(name: "Protocol_#{i}_#{j}",
		    	                                 revision: "v1")
			protocol.save!

			puts "create testsuites"

			3.times do |m|
			    suite = protocol.testsuites.create!(name: "testsuite_#{i}_#{j}_#{m}")
			    suite.save!
					puts "create testcases with random exection time"

					5.times do |n|
							testcase = suite.testcases.create!(name: "testcase_#{i}_#{j}_#{m}_#{n}",
																				execution_time: Time.at(rand *(3600-1) + 1))
							testcase.save!

							puts "create case_result"
							CaseResult.create!(result: "#{["Pass","Fail","Disabled"].sample}",
																	testcase_id: testcase.id)
					end
			end
		end
	end
	#
	puts "Protocol: create documentation"
	protocol = Protocol.last
	Documentation.create!(body: "protocol documentation",
	                      documentable_type: "Protocol",
	                      documentable_id: protocol.id)


	puts "Protocol: create user_testing"

	UserTesting.create(user_id: user_1.id,
										 user_role: "executor",
										 user_testable_type: "Protocol",
										 user_testable_id: protocol.id )

	UserTesting.create(user_id: user_1.id,
										user_role: "modifier",
										user_testable_type: "Protocol",
										user_testable_id: Protocol.first.id )

	UserTesting.create(user_id: user_2.id,
										user_role: "executor",
										user_testable_type: "Protocol",
										user_testable_id: Protocol.first.id )

	UserTesting.create(user_id: user_1.id,
										 user_role: "modifier",
										 user_testable_type: "Protocol",
										 user_testable_id: protocol.id )

	testsuite = Testsuite.last

	puts "Testsuite: create documentation"
	# used like Testcase.last.documentation
	Documentation.create!(body: "testsuite documentation",
	                      documentable_type: "Testsuite",
	                      documentable_id: testsuite.id)

	puts "Testsuite: create keyword_testing"
	KeywordTesting.create(keyword_id:kw_1.id,
										 keyword_role: "suite setup",
										 keywordable_type: "Testsuite",
										 keywordable_id: testsuite.id )

	KeywordTesting.create(keyword_id:kw_2.id,
										 keyword_role: "test setup",
										 keywordable_type: "Testsuite",
										 keywordable_id: testsuite.id )

	puts "Testsuite: create test_tagging"
	TestTagging.create(tag_id: tag_1.id,
										 tag_role: "default tag",
										 test_taggable_type: "Testsuite",
										 test_taggable_id: testsuite.id )

	TestTagging.create(tag_id: tag_2.id,
										 tag_role: "default tag",
										 test_taggable_type: "Testsuite",
										 test_taggable_id: testsuite.id )

	TestTagging.create(tag_id: tag_1.id,
										 tag_role: "force tag",
										 test_taggable_type: "Testsuite",
										 test_taggable_id: Testsuite.first.id )

  puts "Testsuite: create usertesting"
	UserTesting.create(user_id: user_1.id,
										user_role: "executor",
										user_testable_type: "Testsuite",
										user_testable_id: testsuite.id )

	UserTesting.create(user_id: user_2.id,
										user_role: "executor",
										user_testable_type: "Testsuite",
										user_testable_id: testsuite.id )

	UserTesting.create(user_id: user_1.id,
									 user_role: "modifier",
									 user_testable_type: "Testsuite",
									 user_testable_id: Testsuite.first.id )

	UserTesting.create(user_id: user_1.id,
										user_role: "modifier",
										user_testable_type: "Testsuite",
										user_testable_id: testsuite.id )


	testcase = Testcase.last
	puts "Testcase: create documentation"
	Documentation.create!(body: "testcase documentation",
												documentable_type: "Testcase",
												documentable_id: testcase.id)

	puts "Testcase: create keyword_testing"
	KeywordTesting.create(keyword_id:kw_1.id,
										 keyword_role: "setup",
										 keywordable_type: "Testcase",
										 keywordable_id: testcase.id )

	KeywordTesting.create(keyword_id:kw_2.id,
										 keyword_role: "teardown",
										 keywordable_type: "Testcase",
										 keywordable_id: testcase.id )

	puts "Testcase: create test_tagging"
	TestTagging.create(tag_id: tag_1.id,
										 tag_role: "tag",
										 test_taggable_type: "Testcase",
										 test_taggable_id: testcase.id )

	puts "Testcase: create usertesting"
	UserTesting.create(user_id: user_1.id,
										user_role: "modifier",
										user_testable_type: "Testcase",
										user_testable_id: testcase.id )

	UserTesting.create(user_id: user_2.id,
									 user_role: "creator",
									 user_testable_type: "Testcase",
									 user_testable_id: testcase.id )

	puts "Testcase: create keywordtesting"
	KeywordTesting.create(keyword_id:kw_1.id,
										 keyword_role: "setup",
										 keywordable_type: "Testcase",
										 keywordable_id: testsuite.id )

	KeywordTesting.create(keyword_id:kw_2.id,
										 keyword_role: "teardown",
										 keywordable_type: "Testcase",
										 keywordable_id: testcase.id )

	puts "Testcase: create teststeps"
	KeywordTesting.create(keyword_id:kw_1.id,
										 keyword_role: "teststep",
										 keywordable_type: "Testcase",
										 keywordable_id: testcase.id )

	KeywordTesting.create(keyword_id:kw_2.id,
										 keyword_role: "teststep",
										 keywordable_type: "Testcase",
										 keywordable_id: testcase.id )
