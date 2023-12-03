(() => {
    getAllDrivers();
    configureSearchForm();

    function getAllDrivers() {
        fetch('/taxi.xml')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                return response.text();
            })
            .then(data => {
                const parser = new DOMParser();
                const xmlDoc = parser.parseFromString(data, 'application/xml');

                const drivers = xmlDoc.getElementsByTagName('driver');
                generateDriversHTML(drivers);
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    function generateDriversHTML(drivers) {
        const resultContainer = document.getElementById("js-results");

        const table = document.createElement('table');
        table.classList.add('table');
        table.classList.add('mt-3');

        const thead = document.createElement('thead');
        const headerRow = document.createElement('tr');
        const headers = ['Driver ID', 'Personal Identification Number', 'First Name', 'Middle Name', 'Last Name', 'Age', 'Gender', 'IsActive', 'Rating'];

        headers.forEach(headerText => {
            const th = document.createElement('th');
            th.appendChild(document.createTextNode(headerText));
            headerRow.appendChild(th);
        });

        thead.appendChild(headerRow);
        table.appendChild(thead);


        const tbody = document.createElement('tbody');
        for (let index = 0; index < drivers.length; index++) {
            const driver = drivers[index];

            const personalIdentificationNumber = driver.getElementsByTagName('personalIdentificationNumber')[0].textContent;
            const names = driver.getElementsByTagName('names')[0];
            const firstName = names.getElementsByTagName('first')[0].textContent;
            const middleName = names.getElementsByTagName('middle')[0].textContent;
            const lastName = names.getElementsByTagName('last')[0].textContent;

            const age = driver.getAttribute('age');
            const gender = driver.getAttribute('gender');
            const isActive = driver.getAttribute('isActive');
            const rating = driver.getElementsByTagName('rating')[0].textContent;

            const row = document.createElement('tr');
            const cells = [driver.getAttribute('id'), personalIdentificationNumber, firstName, middleName, lastName, age, gender, isActive, rating];

            cells.forEach(cellText => {
                const td = document.createElement('td');
                td.appendChild(document.createTextNode(cellText));
                row.appendChild(td);
            });

            tbody.appendChild(row);
        }

        table.appendChild(tbody);

        resultContainer.innerHTML = null;
        resultContainer.appendChild(table);
    }

    function filterDrivers(formData) {
        fetch('/taxi.xml')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                return response.text();
            })
            .then(data => {
                familyName = "Petrova";

                const parser = new DOMParser();
                const xmlDoc = parser.parseFromString(data, 'application/xml');

                let xpathExpression = '//driver';

                if (formData.firstName) {
                    xpathExpression += `[names/first[contains(., '${formData.firstName}')]]`;
                }
                
                if (formData.middleName) {
                    if (formData.firstName) {
                        xpathExpression = xpathExpression.replace(/\](?=[^\]]*$)/, " and ");
                    }

                    xpathExpression += `names/middle[contains(., '${formData.middleName}')]]`;
                }
                
                if (formData.lastName) {
                    if (formData.firstName || formData.middleName) {
                        xpathExpression = xpathExpression.replace(/\](?=[^\]]*$)/, " and ");
                    }

                    xpathExpression += `names/last[contains(., '${formData.lastName}')]]`;
                }

                const result = document.evaluate(xpathExpression, xmlDoc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

                const drivers = [];
                for (let index = 0; index < result.snapshotLength; index++) {
                    const driverNode = result.snapshotItem(index);
                    drivers.push(driverNode)
                }

                return generateDriversHTML(drivers);
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    function configureSearchForm() {
        document.getElementById('js-filterForm').addEventListener('submit', submitSearchForm);

        function submitSearchForm(event) {
            event.preventDefault();

            const firstName = document.getElementById('first-name').value;
            const middleName = document.getElementById('middle-name').value;
            const lastName = document.getElementById('last-name').value;

            const fromData = {
                firstName,
                middleName,
                lastName
            }

            filterDrivers(fromData);
        }
    }
})();
