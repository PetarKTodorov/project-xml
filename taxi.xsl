<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
        <link rel="stylesheet" type="text/css" href="assets/styles.css" />

        <title>Taxi Company Information</title>
    </head>
    <body>
        <nav class="nav">
            <ul>
                <li>
                    <a href="taxi.xml">To xml file</a>
                </li>
                <li>
                    <a href="index.html">To html file</a>
                </li>
            </ul>
        </nav>

        <xsl:apply-templates select="company"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="company">
    <h1 class="text-center">
        <xsl:value-of select="name"/>
    </h1>

    <section aria-labelledby="base-info">
        <h2 id="base-info">Base company information</h2>

        <div class="table-responsive">
          <table class="table">
              <thead>
                  <tr>
                      <th>Country</th>
                      <th>City</th>
                      <th>Day price per kilometer</th>
                      <th>Night price per kilometer</th>
                      <th>Currency</th>
                  </tr>
              </thead>
          
              <tbody>
                  <tr>
                      <td>
                          <xsl:value-of select="country"/>
                      </td>
                      <td>
                          <xsl:value-of select="city"/>
                      </td>
                      <td>
                          <xsl:value-of select="dayPricePerKm"/>
                      </td>
                      <td>
                          <xsl:value-of select="nightPricePerKm"/>
                      </td>
                      <td>
                          <xsl:value-of select="currency"/>
                      </td>
                  </tr>
              </tbody>
            </table>
        </div>
    </section>
  
  <section class="mt-3" aria-labelledby="all-cars">
    <h2 id="all-cars">All cars</h2>

    <div class="table-responsive">
      <table class="table">
          <thead>
              <tr>
                  <th>ID</th>
                  <th>Number</th>
                  <th>Brand</th>
                  <th>Model</th>
                  <th>Manufacture Date</th>
                  <th>Traveled kilometers</th>
                  <th>Current location</th>
                  <th>Is active</th>
                  <th>Drivers</th>
              </tr>
          </thead>
  
          <tbody>
              <xsl:apply-templates select="cars/car"/>
          </tbody>
      </table>
    </div>
  </section>

  <section class="mt-3" aria-labelledby="filtred-cars">
    <h2 id="filtred-cars">Filtred cars</h2>
    <p>Filtered by mileage over 100,000 km and whether they are currently active.</p>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Number</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Manufacture Date</th>
                    <th>Traveled kilometers</th>
                    <th>Current location</th>
                    <th>Drivers</th>
                </tr>
            </thead>
    
            <tbody>
                <xsl:apply-templates select="cars/car[@isActive='true' and number(traveledKm) > 100000]"/>
            </tbody>
        </table>
    </div>
  </section>

  <section class="mt-3" aria-labelledby="sorted-cars">
    <h2 id="sorted-cars">Sorted cars</h2>
    <p>Sorted by traveledKm (ascending) and driver ratings (descending).</p>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Number</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Manufacture Date</th>
                    <th>Traveled kilometers</th>
                    <th>Current location</th>
                    <th>Drivers</th>
                </tr>
            </thead>
    
            <tbody>
                <xsl:for-each select="cars/car">
                    <xsl:sort select="traveledKm" data-type="number" order="ascending" />
                    <tr>
                        <td>
                            <xsl:value-of select="@id"/>
                        </td>
                        <td>
                            <xsl:value-of select="number"/>
                        </td>
                        <td>
                            <xsl:value-of select="brand"/>
                        </td>
                        <td>
                            <xsl:value-of select="model"/>
                        </td>
                        <td>
                            <xsl:value-of select="manufactureDate"/>
                        </td>
                        <td>
                            <xsl:value-of select="traveledKm"/>
                        </td>
                        <td>
                            Latitude: <xsl:value-of select="currentLocation/@latitude"/>,
                            Longitude: <xsl:value-of select="currentLocation/@longitude"/>
                        </td>
                        <td>
                            <xsl:value-of select="@isActive"/>
                        </td>
                        <td class="p-0">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Names</th>
                                            <th>Age</th>
                                            <th>Gender</th>
                                            <th>Personal Identification Number</th>
                                            <th>Rating</th>
                                        </tr>
                                    </thead>
                            
                                    <tbody>
                                        <xsl:for-each select="drivers/driver">
                                        <xsl:sort select="rating" data-type="number" order="descending" />
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="@id"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="names/first"/>
                                                    <xsl:value-of select="names/middle"/>
                                                    <xsl:value-of select="names/last"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="@age"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="@gender"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="personalIdentificationNumber"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="rating"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </div>
  </section>

  <section class="mt-3" aria-labelledby="filtred-and-sorted-cars">
    <h2 id="filtred-and-sorted-cars">Filtred and sorted cars</h2>
    <p>Filtered by mileage over 100,000 km and whether they are currently active.</p>
    <p>Sorted by traveledKm (ascending) and driver ratings (descending).</p>
    <p>The drivers over 50 will be highlighted.</p>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Number</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Manufacture Date</th>
                    <th>Traveled kilometers</th>
                    <th>Current location</th>
                    <th>Drivers</th>
                </tr>
            </thead>
    
            <tbody>
                <xsl:for-each select="cars/car[@isActive='true' and number(traveledKm) > 100000]">
                    <xsl:sort select="traveledKm" data-type="number" order="ascending" />
                    <tr>
                        <td>
                            <xsl:value-of select="@id"/>
                        </td>
                        <td>
                            <xsl:value-of select="number"/>
                        </td>
                        <td>
                            <xsl:value-of select="brand"/>
                        </td>
                        <td>
                            <xsl:value-of select="model"/>
                        </td>
                        <td>
                            <xsl:value-of select="manufactureDate"/>
                        </td>
                        <td>
                            <xsl:value-of select="traveledKm"/>
                        </td>
                        <td>
                            Latitude: <xsl:value-of select="currentLocation/@latitude"/>,
                            Longitude: <xsl:value-of select="currentLocation/@longitude"/>
                        </td>
                        <td>
                            <xsl:value-of select="@isActive"/>
                        </td>
                        <td class="p-0">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Names</th>
                                            <th>Age</th>
                                            <th>Gender</th>
                                            <th>Personal Identification Number</th>
                                            <th>Rating</th>
                                        </tr>
                                    </thead>
                            
                                    <tbody>
                                        <xsl:for-each select="drivers/driver">
                                        <xsl:sort select="rating" data-type="number" order="descending" />
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="@id"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="names/first"/>
                                                    <xsl:value-of select="names/middle"/>
                                                    <xsl:value-of select="names/last"/>
                                                </td>
                                                
                                                <td>
                                                    <xsl:if test="number(@age) > 50">
                                                        <xsl:attribute name="class">highlight</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:value-of select="@age"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="@gender"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="personalIdentificationNumber"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="rating"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </div>
  </section>
</xsl:template>

<xsl:template match="car">
    <tr>
        <td>
            <xsl:value-of select="@id"/>
        </td>
        <td>
            <xsl:value-of select="number"/>
        </td>
        <td>
            <xsl:value-of select="brand"/>
        </td>
        <td>
            <xsl:value-of select="model"/>
        </td>
        <td>
            <xsl:value-of select="manufactureDate"/>
        </td>
        <td>
            <xsl:value-of select="traveledKm"/>
        </td>
        <td>
            Latitude: <xsl:value-of select="currentLocation/@latitude"/>,
            Longitude: <xsl:value-of select="currentLocation/@longitude"/>
        </td>
        <td>
            <xsl:value-of select="@isActive"/>
        </td>
        <td class="p-0">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Names</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Personal Identification Number</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
            
                    <tbody>
                      <xsl:apply-templates select="drivers/driver"/>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
</xsl:template>

<xsl:template match="driver">
    <tr>
        <td>
            <xsl:value-of select="@id"/>
        </td>
        <td>
            <xsl:value-of select="names/first"/>
            <xsl:value-of select="names/middle"/>
            <xsl:value-of select="names/last"/>
        </td>
        <td>
            <xsl:value-of select="@age"/>
        </td>
        <td>
            <xsl:value-of select="@gender"/>
        </td>
        <td>
            <xsl:value-of select="personalIdentificationNumber"/>
        </td>
        <td>
            <xsl:value-of select="rating"/>
        </td>
    </tr>
</xsl:template>

</xsl:stylesheet>
