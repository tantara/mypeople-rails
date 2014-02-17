require 'mypeople'

class ApiController < ApplicationController
  def callback
    parse = Rack::Utils.parse_nested_query(request.body.read)

    # 파라미터 출력
    logger.info parse

    unless parse["groupId"].nil? || parse["groupId"].empty? # 그룹방
      # 내용으로 행동
      case parse["content"]
      when "!퇴장"
        Mypeople::Bot::exit(parse["groupId"])
      when "!테스트"
        #mypeople.groupTest(parse["groupId"], parse["buddyId"], parse["content"], '["name":"초대자"]')
      when "!멤버"
        Mypeople::Group.members(parse["groupId"])
      when "!도움"
        mypeople.help_from_group(parse["groupId"], parse["buddyId"])
      else
        # params["action"]으로 행동(rails params[:action]이랑 다름)
        case parse["action"]
        when "sendFromGroup" # 그룹 방의 멤버가 메세지를 썼을때
          mypeople.send_from_group(parse["groupId"], parse["buddyId"], parse["content"])
        when "createGroup" # 그룹이 만들어졌을때
          mypeople.create_group(parse["groupId"], parse["buddyId"])
        when "inviteToGroup" # 다른 멤버가 그룹에 초대되었을때
          mypeople.invite_to_group(parse["groupId"], parse["buddyId"])
        when "exitFromGroup" # 친구가 그룹을 나갔을때
          mypeople.exit_from_group(parse["groupId"], parse["buddyId"])
        when "helpFromGroup" # 모바일 폰에서 친구가 '도움말'을 눌렀을때
          mypeople.help_from_group(parse["groupId"], parse["buddyId"])
        when "exitBot" # 모바일 폰에서 친구가 '퇴장 혹은 내보내기'을 눌렀을때
          #mypeople.exit_bot(parse["groupId"], parse["buddyId"])
          Mypeople::Bot::exit(parse["groupId"])
        end
      end
    else # 개인방
      # 내용으로 행동
      case parse["content"]
      when "!테스트"
        #mypeople.buddyTest(parse["buddyId"], parse["content"])
      when "!도움"
        mypeople.help_from_message(parse["buddyId"])
      when "!이미지"
        mypeople.sendFromImage(parse["buddyId"])
      when "!프로필"
        mypeople.profileDownload(parse["buddyId"])
      else
        # params["action"]으로 행동(rails params[:action]이랑 다름)
        case parse["action"]
        when "addBuddy" # 친구가 '나의 봇'을 친구 추가했을때
          mypeople.addBuddy(parse["buddyId"])
        when "sendFromMessage" # 친구가 메세지를 썼을때
          mypeople.send_from_message(parse["buddyId"], parse["content"])
        when "helpFromMessage" # 모바일 폰에서 친구가 '도움말'을 눌렀을때
          mypeople.help_from_message(parse["buddyId"])
        end
      end
    end

    render :json => {:status => 200, :content => parse}
  end
end
