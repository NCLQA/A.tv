*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    ATV.resource
Suite Setup    에이닷 실행
Test Setup    ATV 종료 후 재진입

*** Test Cases ***

맨 위로 버튼
    FOR  ${i}  IN RANGE    0    10
        Swipe By Percent    50    90    50    10
        ${pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo:id/goToTop
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Click Element    com.skt.nugu.apollo:id/goToTop
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="A. tv"]

