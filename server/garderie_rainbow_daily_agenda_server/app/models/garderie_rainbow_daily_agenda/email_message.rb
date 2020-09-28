class GarderieRainbowDailyAgenda
  class EmailMessage
    REGEX_CONTENT_ID = /^<(.*)>$/
    
    def initialize(child)
      @child = child
    end
    
    def to_mail
      from_email = EmailService.instance.from_email
      from_name = EmailService.instance.from_name
      from = "\"#{from_name}\" <#{from_email}>"
      to = @child.email
      subject = "#{@child.name} Daily Report"
      Mail.new do
        from from
        to to
        subject subject
      end.tap do |mail|
        FileUtils.mkdir_p('images')
        attachment1 = File.join('images', 'garderie_rainbow_daily_agenda_logo.png')
        FileUtils.cp(File.join(Rails.root.to_s, 'app', 'assets', 'images', 'garderie_rainbow_daily_agenda_logo.png'), attachment1) unless File.exist?(attachment1)
        mail.add_file(attachment1)
        attachment2 = File.join('images', 'baby_milk_bottle.png') 
        FileUtils.cp(File.join(Rails.root.to_s, 'app', 'assets', 'images', 'baby_milk_bottle.png'), attachment2) unless File.exist?(attachment2)
        mail.add_file(attachment2) 
        attachment3 = File.join('images', 'milk_glass.png')
        FileUtils.cp(File.join(Rails.root.to_s, 'app', 'assets', 'images', 'milk_glass.png'), attachment3) unless File.exist?(attachment3)
        mail.add_file(attachment3) 
        body = html(mail.attachments)
        mail.html_part = Mail::Part.new do
          content_type 'text/html; charset=UTF-8'
          body body
        end
      end
    end
    
    def html(attachments)
      <<~HTML
        <html>
           <head></head>
           <body dir="auto" style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;">
              <div dir="ltr">
                 <div dir="ltr">
                    <div dir="ltr">
                       <div dir="ltr">
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><img src="cid:#{attachments[0].content_id.match(REGEX_CONTENT_ID)[1]}" /></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 18pt;">Agenda Quotidien / Daily Agenda</span></b></p>
                          <p align="center" style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif; text-align: center;"><b><span lang="FR" style="font-size: 14pt;">&nbsp;</span></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR-CA" style="font-size: 14pt;">Nom de l’enfant&nbsp;</span></b><b><span lang="FR" style="font-size: 14pt;">/ Child's Name:&nbsp;#{@child.name}</span></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;"><br clear="none"></span></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;"><br clear="none"></span></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR-CA" style="font-size: 14pt; color: rgb(255, 192, 0);">Ce que j'ai mangé aujourd'hui&nbsp;</span></b><b><span lang="FR" style="font-size: 14pt; color: rgb(255, 192, 0);">/ What I ate Today</span></b><b><u><span lang="FR-CA" style="font-size: 14pt; color: rgb(255, 192, 0);"></span></u></b></p>
                          <table width="" style="border-collapse: collapse;">
                             <tbody>
                                <tr>
                                   <td colspan="1" rowspan="1" width="208" style="width: 155.65pt; border: 1pt solid windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">Repas / Meal</span></b><span lang="EN-US"></span></div>
                                   </td>
                                   <td colspan="3" rowspan="1" width="416" style="width: 311.65pt; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">J’ai mangé/How much I ate</span></b><span lang="EN-US"></span></div>
                                   </td>
                                </tr>
                                <tr>
                                   <td colspan="1" rowspan="1" width="208" style="width: 155.65pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></b><span lang="EN-US"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="128" style="width: 96.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 12pt;">Un peu/A bit</span></b><span lang="EN-US" style="font-size: 12pt;"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="136" style="width: 101.95pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 12pt;">1 Portion/serving</span></b><span lang="EN-US" style="font-size: 12pt;"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="151" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 12pt;">2 Portions/servings</span></b><span lang="EN-US" style="font-size: 12pt;"></span></div>
                                   </td>
                                </tr>
                                <tr>
                                   <td colspan="1" rowspan="1" width="208" style="width: 155.65pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 12pt;">Déjeuner/Breakfast🥐</span></b><b><span lang="EN-US" style="font-size: 12pt; font-family: Color;">🍞</span></b><span lang="EN-US" style="font-size: 12pt;"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="128" style="width: 96.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:breakfast].a_bit}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="136" style="width: 101.95pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:breakfast].one_serving}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="151" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:breakfast].two_servings}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                </tr>
                                <tr>
                                   <td colspan="1" rowspan="1" width="208" style="width: 155.65pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 12pt;">Dîner/Lunch&nbsp;</span></b><b><span lang="EN-US" style="font-size: 12pt; font-family: Color;">🍽🍗🍲</span></b><span lang="EN-US" style="font-size: 12pt;"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="128" style="width: 96.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:lunch].a_bit}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="136" style="width: 101.95pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:lunch].one_serving}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="151" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:lunch].two_servings}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                </tr>
                                <tr>
                                   <td colspan="1" rowspan="1" width="208" style="width: 155.65pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="FR" style="font-size: 12pt;">Collation d’aprés midi/PM Snack&nbsp;</span></b><b><span lang="EN-US" style="font-size: 12pt; font-family: Color;">🍎🍐🍌🍉</span></b><span lang="FR" style="font-size: 12pt;"></span></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="128" style="width: 96.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="FR" style="font-size: 14pt;">#{'x' if @child.meals[:pm_snack].a_bit}&nbsp;</span><span lang="FR"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="136" style="width: 101.95pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.meals[:pm_snack].one_serving}&nbsp;</span><span lang="EN-US"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="151" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; width: 199px;">
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="FR" style="font-size: 14pt;">#{'x' if @child.meals[:pm_snack].two_servings}&nbsp;</span><span lang="FR"></span></p>
                                   </td>
                                </tr>
                             </tbody>
                          </table>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><u><span lang="FR" style="font-size: 14pt; color: rgb(255, 192, 0);"></span></u></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt; color: rgb(0, 176, 80);"><br clear="none"></span></b></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><br clear="none"></p>
                          <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt; color: rgb(0, 176, 80);">Comment j’ai bu</span><font color="#6aa84f"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span><span lang="EN-US" style="font-size: 14pt;">/&nbsp;</span></font></b><b><span lang="EN-US" style="font-size: 14pt; color: rgb(0, 176, 80);">How much I drank&nbsp;</span></b></p>
                          <table width="" style="border-collapse: collapse; border: none;">
                             <tbody>
                                <tr>
                                   <td colspan="1" rowspan="1" width="312" style="width: 233.75pt; border: 1pt solid windowtext; padding: 0cm 5.4pt;">
                                      <div><img src="cid:#{attachments[1].content_id.match(REGEX_CONTENT_ID)[1]}" />&nbsp;<img height=48 width=48 src="cid:#{attachments[2].content_id.match(REGEX_CONTENT_ID)[1]}" />&nbsp;<b style="font-family: Calibri, sans-serif; font-size: 11pt;"><span lang="FR" style="font-size: 14pt;">L’heure du lait /milk</span></b><b style="font-family: Calibri, sans-serif; font-size: 11pt;"><span lang="FR" style="font-size: 14pt;">&nbsp;time</span></b></div>
                                      <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="FR" style="font-size: 12pt; font-family: &quot;New serif&quot;;"></span></p>
                                   </td>
                                   <td colspan="1" rowspan="1" width="312" style="border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt; width: 395px;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">Combien de fluide/How much fluid</span></b><span lang="EN-US" style="font-size: 12pt; font-family: &quot;New serif&quot;;"></span></div>
                                   </td>
                                </tr>
                                #{
                                  @child.drinks.empty? ?
                                  <<~PARTIAL_HTML
                                <tr>
                                   <td colspan="1" rowspan="1" width="312" style="width: 233.75pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><br clear="none"></div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="312" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt; color: red;"></span></b></div>
                                   </td>
                                </tr>                                  
                                  PARTIAL_HTML
                                  : @child.drinks.map do |drink|
                                  <<~PARTIAL_HTML
                                <tr>
                                   <td colspan="1" rowspan="1" width="312" style="width: 233.75pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;">#{drink.milk_time_string}</div>
                                   </td>
                                   <td colspan="1" rowspan="1" width="312" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                      <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;">#{drink.fluid_amount}<b><span lang="EN-US" style="font-size: 14pt; color: red;"></span></b></div>
                                   </td>
                                </tr>                                  
                                  PARTIAL_HTML
                                  end.join("\n")
                                }
                             </tbody>
                          </table>
                          <div style="margin: 2px 0px 0px;">
                             <div id="yiv9257958770m_3525735750411388787gmail-m_-2542126869724280974m_6040930044212218492gmail-m_-1496806213122576357gmail-:35f"><img id="yiv9257958770ymail_ctr_id_-625324-4"></div>
                          </div>
                          <div>
                             <div></div>
                             <div>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt; color: rgb(68, 114, 196);">Sieste/Naptime:&nbsp;<u><img id="yiv9257958770ymail_ctr_id_-673840-5" alt="Animated GIF" width="50" height="50" src="https://1.bp.blogspot.com/-Ajt28gJ5T0A/WLrnwTIlhfI/AAAAAAAAU-c/LfulclQ_b4Eamokz2JA__ukY6kKC2Og5wCLcB/s1600/sleeping-animated-emoji.gif" style="max-height: 360px; width: 50px; min-height: 50px;"></u></span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt; color: rgb(68, 114, 196);"><u><br clear="none"></u></span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;">Je me suis endormi à /&nbsp;</span></b><b style="font-size: 11pt;"><span lang="FR" style="font-size: 14pt;">I fell asleep at:&nbsp;#{@child.nap_time_start_string}</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;">Jusqu’à&nbsp;/ Until:&nbsp;#{@child.nap_time_end_string}</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;"><br clear="none"></span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt; color: rgb(112, 48, 160);">Temps à la toilette / Potty times:</span></b></p>
                                <table width="" style="border-collapse: collapse; border: none;">
                                   <tbody>
                                      <tr style="min-height: 14.9pt;">
                                         <td colspan="1" rowspan="1" width="131" style="width: 98.2pt; border: 1pt solid windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">L’heure change / Time changed</span></b></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="120" style="width: 90.3pt; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">Mouillé/Wet</span></b></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="118" style="width: 88.85pt; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">BM</span></b></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="110" style="width: 82.4pt; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">Couche/Diaper</span></b></div>
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt; font-family: Helvetica;"><img id="yiv9257958770ymail_ctr_id_-745310-6" alt="Animated GIF" width="94.39772033691406" height="94.39772033691406" src="https://cdn.shopify.com/s/files/1/0755/5745/products/diaper-size2-spin_large.gif?v=1521833808" style="max-height: 360px; width: 94.3977px; min-height: 94.3977px;"></span><b><span lang="EN-US" style="font-size: 14pt;"></span></b></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="144" style="width: 151px; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="EN-US" style="font-size: 14pt;">Toilette/Toilet</span></b></div>
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b style="font-size: 11pt; font-style: inherit;"><span lang="EN-US" style="font-size: 14pt;"><img id="yiv9257958770ymail_ctr_id_-274563-7" alt="Animated GIF" width="91.21589660644531" height="91.21589660644531" src="https://i0.wp.com/daddilife.com/wp-content/uploads/2017/02/Potty-Training.gif?resize=150%2C150&amp;ssl=1" style="max-height: 360px; width: 91.2159px; min-height: 91.2159px;"></span></b><br clear="none"></div>
                                         </td>
                                      </tr>
                                      #{
                                        @child.potty_times.empty? ?
                                          <<~PARTIAL_HTML
                                      <tr>
                                         <td colspan="1" rowspan="1" width="131" style="width: 98.2pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="120" style="width: 90.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="118" style="width: 88.85pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="110" style="width: 82.4pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="144" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></p>
                                         </td>
                                      </tr>
                                          PARTIAL_HTML
                                        : @child.potty_times.map do |potty_time|
                                          <<~PARTIAL_HTML
                                      <tr>
                                         <td colspan="1" rowspan="1" width="131" style="width: 98.2pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{potty_time.change_time_string}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="120" style="width: 90.3pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if potty_time.wet}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="118" style="width: 88.85pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if potty_time.bm}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="110" style="width: 82.4pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if potty_time.diaper}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="144" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if potty_time.toilet}&nbsp;</span></p>
                                         </td>
                                      </tr>                                          
                                          PARTIAL_HTML
                                        end.join("\n")                        
                                      }
                                   </tbody>
                                </table>
                                <div style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span><br class="webkit-block-placeholder"></div>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt; color: rgb(0, 176, 240);">Mon humeur était / My mood was:</span></b></p>
                                <table width="" style="border-collapse: collapse; border: none;">
                                   <tbody>
                                      <tr>
                                         <td colspan="1" rowspan="1" width="156" style="width: 116.85pt; border: 1pt solid windowtext; padding: 0cm 5.4pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; text-align: center; line-height: normal;"><span lang="EN-US"><img id="yiv9257958770ymail_ctr_id_-807641-8" alt="Animated GIF" width="67.53408813476562" height="67.53408813476562" src="https://milifemijourney.files.wordpress.com/2011/06/ist2_437828_giant_smiley_big_smile.gif?w=300&amp;h=300" style="max-height: 360px; width: 67.5341px; min-height: 67.5341px;"></span><span lang="EN-US" style="font-size: 14pt;"></span></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="156" style="width: 180px; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img id="yiv9257958770ymail_ctr_id_-959067-9" alt="Animated GIF" width="67.49999237060548" height="67.49999237060548" src="https://media1.tenor.com/images/36c02f1d85ff25a70f9e17bf0fd6223a/tenor.gif?itemid=3532559" style="max-height: 360px; width: 67.5px; min-height: 67.5px;"><br clear="none"></td>
                                         <td colspan="1" rowspan="1" width="156" style="width: 181px; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img id="yiv9257958770ymail_ctr_id_-860925-10" alt="Animated GIF" width="77.53408813476562" height="77.53408813476562" src="https://media2.giphy.com/media/3OpJMkI3B6aWIXbVz4/source.gif" style="max-height: 360px; width: 77.5341px; min-height: 77.5341px;"><br clear="none"></td>
                                         <td colspan="1" rowspan="1" width="156" style="width: 150px; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt;">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img id="yiv9257958770ymail_ctr_id_-801741-11" alt="Animated GIF" width="61.03408813476562" height="61.03408813476562" src="https://s-media-cache-ak0.pinimg.com/originals/ff/39/3c/ff393c68c728948d79994563bd34ce5c.gif" style="max-height: 360px; width: 61.0341px; min-height: 61.0341px;"><br clear="none"></td>
                                      </tr>
                                      <tr>
                                         <td colspan="1" rowspan="1" width="156" style="width: 116.85pt; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.mood.very_happy}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="156" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.mood.happy}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="156" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.mood.unsure}&nbsp;</span></p>
                                         </td>
                                         <td colspan="1" rowspan="1" width="156" style="border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.mood.sad}&nbsp;</span></p>
                                         </td>
                                      </tr>
                                   </tbody>
                                </table>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR-CA" style="font-size: 14pt; color: rgb(255, 89, 247);">S'il vous plaît amenez/</span></b><b><span lang="FR" style="font-size: 14pt; color: rgb(255, 89, 247);">Please bring:</span></b><b><u><span lang="FR-CA" style="font-size: 14pt; color: rgb(255, 89, 247);"></span></u></b></p>
                                <table width="633" style="width: 474.9pt; border-collapse: collapse; border: none;">
                                   <tbody>
                                      <tr style="min-height: 15.95pt;">
                                         <td colspan="1" rowspan="1" width="76" style="width: 2cm; border: 1pt solid windowtext; padding: 0cm 5.4pt; min-height: 15.95pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.bring_diapers}&nbsp;</span></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="558" style="width: 418.2pt; border-top-width: 1pt; border-style: solid solid solid none; border-top-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; padding: 0cm 5.4pt; min-height: 15.95pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="FR-CA" style="font-size: 14pt;">Couche/</span><span lang="EN-US" style="font-size: 14pt;">Diapers</span></b></div>
                                         </td>
                                      </tr>
                                      <tr style="min-height: 22.15pt;">
                                         <td colspan="1" rowspan="1" width="76" style="width: 2cm; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt; min-height: 22.15pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.bring_extra_clothes}&nbsp;</span></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="558" style="width: 418.2pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; min-height: 22.15pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="FR-CA" style="font-size: 14pt;">Vêtements supplémentaires/</span><span lang="EN-US" style="font-size: 14pt;">Extra clothes</span><span lang="FR-CA" style="font-size: 14pt;"></span></b></div>
                                         </td>
                                      </tr>
                                      <tr style="min-height: 18.65pt;">
                                         <td colspan="1" rowspan="1" width="76" style="width: 2cm; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt; min-height: 18.65pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{'x' if @child.bring_special_milk_or_formula}&nbsp;</span></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="558" style="width: 418.2pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; min-height: 18.65pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="FR-CA" style="font-size: 14pt;">Lait ou formule spéciale/</span><span lang="FR" style="font-size: 14pt;">Special milk or formula</span><span lang="FR-CA" style="font-size: 14pt;"></span></b></div>
                                         </td>
                                      </tr>
                                      <tr style="min-height: 17.7pt;">
                                         <td colspan="1" rowspan="1" width="76" style="width: 2cm; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt; min-height: 17.7pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="FR" style="font-size: 14pt;">#{'x' if @child.bring_wipes}&nbsp;</span></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="558" style="width: 418.2pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; min-height: 17.7pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><b><span lang="FR-CA" style="font-size: 14pt;">Lingettes/</span><span lang="EN-US" style="font-size: 14pt;">Wipes</span><span lang="FR" style="font-size: 14pt;"></span></b></div>
                                         </td>
                                      </tr>
                                      <tr style="min-height: 17.7pt;">
                                         <td colspan="1" rowspan="1" width="76" style="width: 2cm; border-right-width: 1pt; border-style: none solid solid; border-right-color: windowtext; border-bottom-width: 1pt; border-bottom-color: windowtext; border-left-width: 1pt; border-left-color: windowtext; padding: 0cm 5.4pt; min-height: 17.7pt;">
                                            <div style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; line-height: normal;"><b><span style="font-size: medium;"><font face="arial, sans-serif">Autre/Other:</font></span></b></div>
                                         </td>
                                         <td colspan="1" rowspan="1" width="558" style="width: 418.2pt; border-style: none solid solid none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; min-height: 17.7pt;">
                                            <p style="margin: 0cm 0cm 0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif; line-height: normal;"><span lang="EN-US" style="font-size: 14pt;">#{@child.bring_other}</span><span lang="FR" style="font-size: 14pt;"></span></p>
                                         </td>
                                      </tr>
                                   </tbody>
                                </table>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt;">Je me suis amusé quand/I had fun when we:&nbsp;#{@child.i_had_fun_when_we}</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="EN-US" style="font-size: 14pt;">&nbsp;</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR-CA" style="font-size: 14pt;">Notes spéciales /&nbsp;</span></b><b><span lang="FR" style="font-size: 14pt;">Special notes:&nbsp;#{@child.special_notes}</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;">&nbsp;</span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;">Nom de l’éducatrice / Educator name:&nbsp;#{@child.educator_name}</span></b><span lang="FR-CA" style="font-size: 14pt;"></span></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;"><b><span lang="FR" style="font-size: 14pt;"><br clear="none"></span></b></p>
                                <p style="margin: 0cm 0cm 8pt; line-height: 15.6933px; font-family: Calibri, sans-serif;"><b><span lang="FR"><font size="4"><font color="#f1c232">HAVE A NICE DAY</font>&nbsp;<span style="margin-right: 0.2ex; margin-left: 0.2ex; vertical-align: middle; min-height: 24px; width: 24px;">🤗</span></font></span></b></p>
                                <div></div>
                             </div>
                          </div>
                          <div>
                             <div dir="ltr">
                                <div dir="ltr">
                                   <div style="font-size: 12pt; font-family: &quot;Sans fantasy&quot;, cursive;"><span style="color: rgb(255, 0, 0); font-size: 9pt;"><br clear="none"></span></div>
                                   <div style="font-size: 12pt; font-family: &quot;Sans fantasy&quot;, cursive;"><br clear="none"></div>
                                   <div style="font-size: 16px; font-family: &quot;Sans Chalkboard&quot;, cursive, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;;">
                                      <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="font-family: Candara, sans-serif; font-size: 9pt; color: rgb(0, 111, 201);"></span></div>
                                   </div>
                                </div>
                             </div>
                          </div>
                       </div>
                    </div>
                 </div>
                 <div>
                    <div dir="ltr">
                       <div dir="ltr">
                          <br clear="none">
                          <div>
                             <div style="font-size: 12pt; font-family: &quot;Sans fantasy&quot;, cursive;"><br clear="none"></div>
                             <div style="font-size: 16px; font-family: &quot;Sans Chalkboard&quot;, cursive, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;;">
                                <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="font-family: Candara, sans-serif; font-size: 9pt; color: rgb(0, 111, 201);"></span></div>
                             </div>
                          </div>
                       </div>
                    </div>
                 </div>
              </div>
              <div>
                 <div dir="ltr">
                    <div dir="ltr">
                       <br clear="none">
                       <div>
                          <div style="font-size: 12pt; font-family: &quot;Sans fantasy&quot;, cursive;"><span style="color: rgb(255, 0, 0); font-size: 9pt;">Garderie Rainbow</span></div>
                          <div style="font-size: 16px; font-family: &quot;Sans Chalkboard&quot;, cursive, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;, Chalkboard, EmojiFont, &quot;Color UI NotoColorEmoji&quot;, &quot;UI EmojiSymbols&quot;;">
                             <font color="#ff0000" face="Candara, sans-serif"><span style="font-size: 12px; color: rgb(0, 0, 0);">Tel: 514-559-2600<br clear="none"></span></font><span style="color: rgb(255, 0, 0); font-family: Candara, sans-serif; font-size: 9pt;"></span>
                             <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="color: rgb(255, 0, 0); font-family: Candara, sans-serif; font-size: 9pt;"></span><span style="font-family: Candara, sans-serif; font-size: 9pt;">2005 Rue Saint Jacques.&nbsp;</span></div>
                             <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;">
                                <span style="font-family: Candara, sans-serif; font-size: 9pt;"></span><span style="font-family: Candara, sans-serif; font-size: 9pt;">Montréal, Qc H3J 1H3</span><span style="font-family: Candara, sans-serif; font-size: 9pt;"></span>
                                <div><span style="font-family: Candara, sans-serif; font-size: 9pt;"></span></div>
                             </div>
                             <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="font-family: Candara, sans-serif; font-size: 9pt; color: rgb(0, 111, 201);"><a rel="nofollow" shape="rect" target="_blank" href="http://www.garderierainbow.com/" style="color: rgb(25, 106, 212);">www.garderierainbow.com</a></span></div>
                             <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="font-family: Candara, sans-serif; font-size: 9pt; color: rgb(0, 111, 201);"><a rel="nofollow" shape="rect" target="_blank" href="https://www.facebook.com/garderierainbowdemontreal/">fb Garderie Rainbow</a></span></div>
                             <div style="font-family: &quot;Sans fantasy&quot;, cursive; font-size: 12pt;"><span style="font-family: Candara, sans-serif; font-size: 9pt; color: rgb(0, 111, 201);"><a rel="nofollow" shape="rect" target="_blank" href="https://www.instagram.com/garderie_rainbow_montreal/">instagram garderie_rainbow_montreal</a></span></div>
                          </div>
                       </div>
                    </div>
                 </div>
              </div>
           </body>
        </html>
      HTML
    end
  end
end
