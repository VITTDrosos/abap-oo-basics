"! <p class="shorttext synchronized" lang="en">Flight Data as Instance Methods</p>
CLASS ZCL_OO_TUTORIAL_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! <p class="shorttext synchronized" lang="en">Flight</p>
    DATA FLIGHT TYPE /DMO/FLIGHT.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS CONSTRUCTOR
      IMPORTING
        !CARRIER_ID    TYPE /DMO/CARRIER_ID
        !CONNECTION_ID TYPE /DMO/CONNECTION_ID
        !FLIGHT_DATE   TYPE /DMO/FLIGHT_DATE.

    "! <p class="shorttext synchronized" lang="en">Get Booking Details</p>
    METHODS GET_FLIGHT_DETAILS
      RETURNING VALUE(FLIGHT) TYPE /DMO/FLIGHT .

    "! <p class="shorttext synchronized" lang="en">Calculate Flight Price</p>
    METHODS CALCULATE_FLIGHT_PRICE
      EXPORTING
        !PRICE         TYPE /DMO/FLIGHT_PRICE
        !CURRENCY_CODE TYPE /DMO/CURRENCY_CODE.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_OO_TUTORIAL_3 IMPLEMENTATION.


  METHOD CALCULATE_FLIGHT_PRICE.

    PRICE = ME->FLIGHT-PRICE.
    CURRENCY_CODE = ME->FLIGHT-CURRENCY_CODE.

    CASE ME->FLIGHT-PLANE_TYPE_ID.
      WHEN '747-400'.
        PRICE = PRICE + 40.
      WHEN 'A310-300'.
        PRICE = PRICE + 25.
      WHEN OTHERS.
        PRICE = PRICE + 10.
    ENDCASE.
  ENDMETHOD.


  METHOD CONSTRUCTOR.
    SELECT SINGLE * FROM /DMO/FLIGHT
      WHERE CARRIER_ID = @CARRIER_ID
        AND CONNECTION_ID = @CONNECTION_ID
        AND FLIGHT_DATE = @FLIGHT_DATE
       INTO @FLIGHT.
  ENDMETHOD.


  METHOD GET_FLIGHT_DETAILS.
    FLIGHT = ME->FLIGHT.
  ENDMETHOD.
ENDCLASS.