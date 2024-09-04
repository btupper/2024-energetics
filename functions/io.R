#' Account lookup
#' 
#' @return a table of account info
downeast_account = function(){
  dplyr::tribble(
    ~name, ~old_id, ~new_id,
    "95Main", "8406090", "1536294",
    "97Main", "8406080", "1536286")
}
#' Read the DownEast report
#' 
#' @param filename the name of the file to read
#' @return table with two sheets merged
read_downeast = function(filename = here::here("data/DeadRiver-FIRSTUNICHURCH.xls")){
  acct = downeast_account()
  lut = acct$name
  names(lut) = acct$old_id
  
  sheets = readxl::excel_sheets(filename)

  lapply(sheets, 
              function(sheet){
                readxl::read_excel(filename, sheet = sheet) |>
                  dplyr::mutate(Account = lut[sheet], Date = as.Date(DeliveryDate), .before = 1) |>
                  dplyr::select(-dplyr::all_of(c("DeliveryDate", "TaxAmount", "ExtendedDocument Total"))) |>
                  dplyr::rename(Cost = SalesAmount)
              }) |>
    dplyr::bind_rows() |>
    dplyr::mutate(Year = format(Date, "%Y"), Month = format(Date, "%b"), .after = Date) |>
    dplyr::filter(Date != as.Date("2021-04-19")) |>
    dplyr::mutate(CostPerUnit = Cost/Quantity)
  
}