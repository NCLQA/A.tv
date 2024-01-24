*** Settings ***
Library  AppiumLibrary

*** Variables ***
${deviceName}    R3CW408AJRK    #테스트대상 단말입력
${appPackage}    com.skt.nugu.apollo   
${appActivity}    com.skt.nugu.visual.home.HomeActivity

*** Keywords ***
에이닷 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true

에이닷 종료 후 재진입
    Wait Until Keyword Succeeds    1 min    3 sec    Terminate Application    ${appPackage}
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Sleep    6
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="앱"]    

TV 메뉴 진입
    FOR  ${i}  IN RANGE    0    5    #TV 메뉴까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]
        Exit For Loop If    ${pass}
    END   
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="TV"]

프로농구 메뉴 진입
    FOR  ${i}  IN RANGE    0    5    #프로농구 메뉴까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="프로농구"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="프로농구"]

full 화면 진입
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo:id/cl_content_area
    Sleep    1
    FOR  ${i}  IN RANGE    0    10
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo:id/tabBorder
        ${pass}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo:id/iv_full
        Exit For Loop If    ${pass}
        Sleep    1
    END   
    Sleep    2