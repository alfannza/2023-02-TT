*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://www.tokopedia.com/
${BROWSER}        Chrome

# top right item assuming 1600*900 resolution, 100% zoom, chrome maximize window
${top-right-item}               xpath://div[@data-testid="divSRPContentProducts"]/div/div[5]
${top-right-item-text}          xpath://div[@data-testid="divSRPContentProducts"]/div/div[5]/div/div/div/div/div/div/div[2]/a


${main_search_btn}              xpath://input[@data-unify="Search"]
${widget_open_btn_loc}          id:widget-activator
${widget_frame_loc}             id:vc-chat-iframe
${widget_open_img_loc}          xpath://*[@id="app"]/div/div[1]/div
${widget_title_loc}             xpath://*[@id="app"]/div/div[1]/div/div[2]
${widget_minimize_btn_loc}      xpath://*[@id="app"]/div/div[1]/div/div[3]
${widget_get_started_btn_loc}   xpath://*[@id="app"]/div/div[3]/div/div
${widget_last_msg_me_loc}       xpath:(//div[@class="vc-message-text-bubble me"])[last()]
${widget_last_msg_bot_loc}      xpath:(//div[@class="vc-message-text-bubble"])[last()]
${widget_input_loc}             xpath://*[@id="app"]/div/div[3]/div/div[1]/input
${widget_hello_btn_loc}         xpath://span[@class="material-design-icon wrench-icon"]
${widget_what_btn_loc}          xpath://div[@class="message-button"][text()=" What "]

*** Test Cases ***
TC-000_Browser_Setup
    open browser    ${LOGIN URL}  ${BROWSER}
    maximize browser window
    title should be    Situs Jual Beli Online Terlengkap, Mudah & Aman | Tokopedia
    sleep   5

TC-001_Navigate_Search
    # click search button
    click element   ${main_search_btn}
    sleep   2

    # type into search
    input text  ${main_search_btn}  laptop asus
    press keys  ${main_search_btn}  \ue006
    sleep   3

TC-002_Validate_Result_Page

    element should be visible    xpath://div[@data-testid="dSRPSearchInfo"]/span
    element should be visible    xpath://div[@data-testid="dSRPSearchInfo"]/strong
    element should be visible    xpath://div[@data-testid="divSRPContentProducts"]

    # validate search result
    element should contain    xpath://div[@data-testid="dSRPSearchInfo"]/span    Menampilkan
    element should contain    xpath://div[@data-testid="dSRPSearchInfo"]/span    barang

    element should contain    xpath://div[@data-testid="dSRPSearchInfo"]/strong    laptop asus

    # try to list all result text in this page
    ${get_text}    get webelements    xpath://div[@data-testid="spnSRPProdName"]
    FOR    ${item}    IN    @{get_text}
        log to console    ${\n}${item.text}
    END



TC-003_Click_Top_Right

    # clicking top right item
    click element    ${top-right-item}

TC-004_Detail_Page_Validation

    sleep    5
    # validate certain element exist after clicking detail product
    # 1. Image product visibility
    # 2. Detail tab visibility

    element should be visible    xpath://img[@data-testid="PDPMainImage"]
    element should be visible    xpath://button[@data-testid="tabPDPDetail"]/p
    element should be visible    xpath://button[text()="Lihat Selengkapnya"]

    # clicking lihat selengkapnya
    click element    xpath://button[text()="Lihat Selengkapnya"]

    # validating certain word "asus" exist in detail product
    element should contain    xpath://div[@data-testid="lblPDPDescriptionProduk"]    ASUS

    ${get_text}    get text    xpath://div[@data-testid="lblPDPDescriptionProduk"]
    log to console    \n${get_text}

TC-ZZZ_Browser_Close
    close browser

*** Keywords ***
