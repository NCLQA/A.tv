*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    ATV.resource
Suite Setup    에이닷 실행
Test Setup    에이닷 종료 후 재진입

*** Test Cases ***

A. tv aar 이 포함 된 에이닷 앱 실행
    [Tags]    General
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true
    Click Element    Xpath=//android.widget.TextView[@text="메뉴"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]       

A. tv 진입
    [Tags]    General
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="A. tv"]

A. tv 종료
    [Tags]    General
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    2
    Wait Until Element Is Visible    com.skt.nugu.apollo:id/buttonExit
    Click Element    com.skt.nugu.apollo:id/buttonExit
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]

PIP 재생 > Player 재생 전환
    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    5
    Click Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[2]/android.widget.FrameLayout[3]/android.widget.FrameLayout/android.view.ViewGroup/androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.view.ViewGroup/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup[2]
    Sleep    1
    Press Keycode    3
    Sleep    2
    Activate Application    com.skt.nugu.apollo
    Sleep    2
    Wait Until Element Is Visible    com.skt.nugu.apollo:id/tv_detail_info_btn

A. tv aar 이 포함 된 에이닷 앱 종료
    [Tags]    General
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    2
    Wait Until Element Is Visible    com.skt.nugu.apollo:id/buttonExit
    Click Element    com.skt.nugu.apollo:id/buttonExit
    Sleep    1
    Press Keycode    4
    Press Keycode    1
    Click Element    com.sec.android.app.launcher:id/clear_all_button
    Sleep    1
    Press Keycode    1
    Sleep    1
    Element Should Be Disabled    com.sec.android.app.launcher:id/clear_all_button   



A. tv aar 이 포함 된 에이닷 앱 로그아웃
    [Tags]    General
    Click Element    Xpath=//android.widget.ImageView[@content-desc="닫기"]
    Sleep    1
    Click Element    xPath=//android.widget.TextView[@text="개인 정보"]
    Sleep    1
    Click Element    xPath=//android.widget.TextView[@text="로그아웃"]
    Sleep    1
    Click Element    com.skt.nugu.apollo:id/positiveButtonText
    Sleep    1
    Click Element    com.skt.nugu.apollo:id/positiveButtonText
    Sleep    1
    Activate Application    com.skt.nugu.apollo
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo:id/intro_login_button




