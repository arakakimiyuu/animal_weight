#東京の時間設定を見やすくする記述
Time::DATE_FORMATS[:datetime_jp] = '%Y年 %m月 %d日 %H時 %M分'
Groupdate.time_zone = false
#Groupdate Gemが依存するSQLiteはTimezoneがなく、Groupdateにそれを伝える必要があった。以下を定義しそれを伝えることでエラーを抑制
