# encoding: UTF-8
require 'fileutils'
desc "time"
task :time => :environment do

profile = Selenium::WebDriver::Firefox::Profile.new
browser = Watir::Browser.new :firefox, :profile => profile
browser.goto 'http://mops.twse.com.tw/mops/web/t57sb01_q1'
	#從檔案開啟
    File.open("/Users/teinakayuu/Desktop/projects/input5.txt","r").each_line do |line|	
    
    #input
    #第一行公司行號 第二行年度 第三行公司名稱
    array = line.split(' ')

    #存檔
    target_dir = array[3]
	#公司代號 年 季別
	browser.text_field(:name => 'co_id').set array[0]
    browser.text_field(:name => 'year').set array[1]
    season = '2'
    
    # Enter
	browser.input(:onclick => "showsh2('quicksearch9','showTable9');document.form1.step.value='4';action='/mops/web/ajax_quickpgm';ajax1(this.form,'quicksearch9');").click
	browser.input(:value => " 搜尋 ").click
	#開新頁面必做
	sleep 10
	browser.windows.last.use
	
	count = 1
	count2 = 1
	fnum = 1
	tnum = 1
	tnumbegin = 1
	filename = {}
	time = {}
	tag={}
	num=1
	i=1

		if  browser.input(:src => "/image/t56sf26.gif").exists?  
			browser.inputs.each do |input|
				if input.src.include? "/image/t56sf26.gif"
					input.click
					sleep 3
					browser.as.each do |a|
						if a.text[5] == season
							if fnum == 1
								tnumbegin = count	
							end
							filename[fnum] = a.text 
							fnum = fnum + 1
						end
						count = count + 1
					end

					#拿到時間
					browser.tds.each do |td| 	
						if td.align == 'cetern' 
							count2 = count2 + 1
						end
						if count2 > tnumbegin && tnum < fnum && td.align == 'cetern'
							time[tnum] = td.text 
							tnum = tnum + 1
						end
					end
						browser.back
						sleep 3
				end
			end
	
			if 	browser.img(:src => "/image/t56sf26.gif").exists?
				browser.as.each do |a|
						tag[num] = a.href
						num = num + 1
				end
			end

			if 	browser.img(:src => "/image/t56sf26.gif").exists?
				for j in 1..num
					browser.as.each do |a|
						if a.href == tag[i]
							a.click
							browser.as.each do |a|
								if a.text[5] == season
									if fnum == 1
										tnumbegin = count	
									end
									filename[fnum] = a.text 
									fnum = fnum + 1
								end
								count = count + 1
							end
							#拿到時間
							browser.tds.each do |td| 	
								if td.align == 'cetern' 
									count2 = count2 + 1
								end

								if count2 > tnumbegin && tnum < fnum && td.align == 'cetern'
									time[tnum] = td.text 
									tnum = tnum + 1
								end
							end
							i = i + 1
							sleep 3
							browser.back
							sleep 3
							j = j + 1
							break
						end #if
					end #each
				end #for
			end #if
	else	

	#拿到檔名
	browser.as.each do |a|
		if a.text[5] == season
				if fnum == 1
						tnumbegin = count	
				end
				filename[fnum] = a.text 
				fnum = fnum + 1
		end
		count = count + 1
	end

	#拿到時間
	browser.tds.each do |td| 	
		if td.align == 'cetern' 
			count2 = count2 + 1
		end

		if count2 > tnumbegin && tnum < fnum && td.align == 'cetern'
			time[tnum] = td.text 
			tnum = tnum + 1
		end
	end
	end	
	#建立檔案
	   path = "/Users/teinakayuu/Desktop/projects/crawler/download/#{target_dir}/file_time"
  		dir = File.dirname(path)

  		unless File.directory?(dir)
    		FileUtils.mkdir_p(dir)
  		end

  	#存公司	
	File.open("/Users/teinakayuu/Desktop/projects/crawler/download/file_time.txt",'a') do |f2|
		f2.puts array[3]
		for i in 1..fnum 
			#f2.puts "#{filename[i]}" + ' ' + "#{time[i]}"
			f2.puts filename[i]
		end
	end
	
	browser.windows.last.close
	sleep 3
	end
	browser.close
	sleep 3
end
