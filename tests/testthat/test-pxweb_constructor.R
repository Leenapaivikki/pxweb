# Test suits for the examples in the documentation

context("pxweb")

test_that(desc="Constructor works as it should with Statistics Sweden",{
  expect_silent(pxapi1 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_true(file.exists(pxapi1$paths$rda_file_path))
  expect_true(length(pxapi1$calls$time_stamps) > 0)
  expect_true(is.pxweb(pxapi1))
  expect_silent(pxapi2 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))  
  expect_true(length(pxapi2$calls$time_stamps) == length(pxapi2$calls$time_stamps))
  
  expect_silent(pxweb:::pxweb_clear_cache(pxapi1))
  
  expect_silent(pxweb(url = "http://api.scb.se/OV0104/v1/doris/sv?config"))
  expect_silent(pxweb(url = "http://api.scb.se/OV0104/v1/doris/sv?config")) # Cached
  expect_silent(pxweb:::pxweb_clear_cache(pxapi1))  
  
  # Handling of subpath
  expect_silent(pxapi1 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_equal(pxapi1$paths$api_subpath$path, "OV0104/v1/doris/sv")
  expect_silent(pxapi1 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/en/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_equal(pxapi1$paths$api_subpath$path, "OV0104/v1/doris/en")
})  


test_that(desc="Constructor works for erroneous urls",{
  expect_silent(pxapi1 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))

  expect_error(pxweb(url = "api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_silent(pxweb(url = "http://api.scb.se/OV0104/v1/dosasasasas"))
  expect_error(pxweb(url = "http://www.statistikdatabasen.scb.se/pxweb/sv/ssd/"))
  expect_error(pxweb(url = "https://sv.wikipedia.org/wiki/ISO_639"))
  expect_silent(pxweb(url = "http://api.scb.se"))
  
  expect_silent(pxweb:::pxweb_clear_cache(pxapi1))
  
  expect_error(pxweb(url = "api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_error(pxweb(url = "http://api.scb.se/OV0104/v1/dosasasasas"))
  expect_error(pxweb(url = "http://api.scb.se"))
  
})  


test_that(desc="Cache cleaner and print",{

  expect_silent(pxapi1 <- pxweb(url ="http://api.scb.se/OV0104/v1/doris/sv/ssd/START/ME/ME0104/ME0104C/ME0104T24"))
  expect_silent(pxapi2 <- pxweb("http://pxnet2.stat.fi/PXWeb/api/v1/fi/StatFin/tym/tyonv/statfin_tyonv_pxt_001.px"))
  expect_true(file.exists(pxapi1$paths$rda_file_path))
  expect_silent(pxweb:::pxweb_clear_cache())
  expect_false(file.exists(pxapi1$paths$rda_file_path))
  
  expect_output(print(pxapi1), "PXWEB API")
})  




