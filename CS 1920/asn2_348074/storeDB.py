# IMPORTS
import csv  # import csv module to read inventory csv file
from store import Store  # import Store class from store.py to create Store objects


class storeDB(object):
    """
    Class to create a database of stores.

    Attributes
    ----------
    __filename : str
        File to be read to create Store objects and products in the store.
    __store_dict : dict
        Dictionary of all contents of file.
    __store_obj_list : list
        List of all unique Store objects created from __store_dict.

    Methods
    -------
    read_file():
        Reads file and adds each line as a unique key value pair in __store_dict.
    store_exists(str_obj):
        Checks if an instance of a given store object exists already in the __store_obj_list.
    add_store_products():
        Creates new Store object then adds it to the __store_obj_list if it does not already exist and adds its respective products.
    print_store_info(str_nm):
        Prints the store ID, name, city, and area of all Stores that match the given name.
    print_product_info(str_id):
        Prints the product ID, number sold, and number available of all products of a Store who matches a given ID.
    remove_store_data(str_id):
        Removes a Store from __store_obj_list that matches a given Store ID number.
    add_new_store(s_nm, s_city, s_area):
        Creates a new Store object of given name, city, and area, and adds it to __store_obj_list if it does not already exist.
    add_new_product(s_id, p_nm, p_sold, p_avl, p_cost, p_price):
        Adds a new product to a Store of given ID number given product name, number sold, number available, cost, and price.
    """

    def __init__(self, filename):
        """
        Construct all the necessary attributes for storeDB.

        Parameters
        ----------
        filename : str
            The csv file to be read.
        """

        self.__filename = filename
        self.__store_dict = {}
        self.__store_obj_list = []

    def read_file(self):
        """
        Read csv file and add key value pair for each line to __store_dict.

        Returns
        -------
        None
        """

        # open file in read mode with UTF-8 encoding
        with open(self.__filename, encoding="UTF-8") as file:
            next(file)  # skip first line in the file as it is just a header

            # initialize a csv reader as some values contain a comma that needs to be kept and not split at
            reader = csv.reader(file, delimiter=',')

            # loop through each line of the file(reader)
            for line in reader:
                # create a list of all the values in a line strip of leading and trailing whitespace
                data = [x.strip() for x in line]

                # add a new entry into the store dictionary with
                # key equal to first item of the line, InventoryId
                # and value equal to the list that is the rest of the line
                self.__store_dict[data[0]] = data[1:]

        # print how many store records were added to the dictionary
        print(f"{len(self.__store_dict)} records added to the dictionary.")

    def store_exists(self, str_obj):
        """
        Check if an instance of a given store object exists already in the __store_obj_list.

        Parameters
        ----------
        str_obj : Store
            Store object to check existence of.

        Returns
        -------
        index : int
            The index of __store_obj_list where the given Store object already exists, -1 if it does not exist.
        """

        index = -1  # assume the given store object does not exist in the store object list to begin

        # loop through the store obj list
        for store in self.__store_obj_list:

            # if the current store's name matches the given store's name check city
            if store.get_store_name() == str_obj.get_store_name():

                # if the current store's city matches the given store's city check area
                if store.get_city() == str_obj.get_city():

                    # if the current store's area matches the given store's area
                    # at this point we have found a matching store
                    if store.get_area() == str_obj.get_area():
                        # set index to the index of the current store in the store object list
                        index = self.__store_obj_list.index(store)
                        break  # break out of the loop as we have found a matching store

        return index  # return the index of the matching store in the store object list

    def add_store_products(self):
        """
        Create new Store object then add it to the __store_obj_list if it does not already exist and add the stores respective products.

        Returns
        -------
        None
        """

        # loop through the values of the store dictionary
        for data in self.__store_dict.values():
            # create a new Store object with the first 3 values of the current value of the store dictionary
            # which are name, city, area
            new_store = Store(data[0], data[1], data[2])

            # check if the newly created Store already exists in the store object list
            index = self.store_exists(new_store)

            # if and only if the new store does not exist
            # add it too the store object list and add its products
            if index == -1:
                # append the new Store to the store object list
                self.__store_obj_list.append(new_store)

                # add a new product to the newly created store with the remaining 5 values of the current value of the
                # store dictionary which are product name, number sold, number available, cost, and retail price
                new_store.add_product(data[3], int(data[4]), int(data[5]), float(data[6]), float(data[7]))

            # if the newly created Store already exists just add its products
            else:
                # if the store exists already index will be the index of the store that already exists
                # thus we go to the that Store in the store object list and add a new product
                # with the last 5 values of the current value of the store dictionary
                # which are product name, number sold, number available, cost, and retail price
                self.__store_obj_list[index].add_product(data[3], int(data[4]), int(data[5]), float(data[6]), float(data[7]))

        # print the total number of stores and the number of unique stores that were created.
        print(f"{len(self.__store_dict)} records added to unique {len(self.__store_obj_list)} stores.")

    def print_store_info(self, str_nm):
        """
        Print the store ID, name, city, and area of all Stores that match the given name.

        Parameters
        ----------
        str_nm : str
            Name of store to print the store info of.

        Returns
        -------
        None
        """

        # print the store name we are searching for
        print(f"Searching for store named {str_nm}")

        count = 0  # initialize count to count how many stores match the given name

        # loop through the store object list
        for store in self.__store_obj_list:
            # IMPORTANT INFORMATION
            identifier = store.get_store_id()  # get the id number of the current store
            name = store.get_store_name()  # get the name of the current store
            city = store.get_city()  # get the city of the current store
            area = store.get_area()  # get the area of the current store

            # if the name of the current store matches the given store name print its info
            if name == str_nm:
                count += 1  # increase count of matching stores

                # print the IMPORTANT INFORMATION of the current store
                print(f"Store_ID:{identifier};Store_Name:{name};Store_City:{city};Store_Area:{area}")

        # print the number of stores found that matched the given name
        print(f"{count} records found for a store named {str_nm}")

    def print_product_info(self, str_id):
        """
        Print the product ID, number sold, and number available of all products of a store that matches a given ID.

        Parameters
        ----------
        str_id : int
            The ID number of the store to print the products of.

        Returns
        -------
        None
        """

        # print the store id we are looking for
        print(f"Printing product list for store ID {str_id}")

        exists = False  # assume that the store of given id does not exist in the store object list to begin

        # loop through the store object list
        for store in self.__store_obj_list:
            # if the current store's id matches the given id
            # print its products if there are any
            if store.get_store_id() == str_id:
                exists = True  # we have found a matching store so change exists to True
                products = store.get_product()  # get the products of the current store which is of type dict

                # if there is at least 1 product in the products dictionary
                # print each products information
                if len(products) > 0:
                    # loop through the values of the products dictionary
                    for product in products.values():
                        # IMPORTANT INFORMATION
                        identifier = product.get_id()  # get the current product's id number
                        name = product.get_name()  # get the current product's name
                        sold = product.get_num_sold()  # get the current product's number of units sold
                        available = product.get_num_available()  # get the current product's number of units available

                        # print the IMPORTANT INFORMATION of the current product
                        print(f"Product ID:{identifier}; Name:{name}; Sold:{sold}; Available:{available}")

                    # break out from looping through the store obj list as we found the store of matching id
                    # and printed all its products
                    break

                # if we have found the store of matching id but it has no products
                # print that there is no products
                else:
                    # print that no products are in the matching store
                    print("No product found!")

                    # break out from looping through the store obj list as we found the store of matching id
                    # but it had no products
                    break

        # if after looping through the whole store object list we did not find a matching store
        # print that no store was found
        if not exists:
            # print that no store matched the given id
            print("Store not found!")

    def remove_store_data(self, str_id):
        """
        Remove a Store from __store_obj_list that matches a given Store ID number.

        Parameters
        ----------
        str_id : int
            The ID number of the store to remove from __store_obj_list.

        Returns
        -------
        None
        """

        found = False  # assume that the store of given id does not exist in the store object list to begin

        # loop through the store object list
        for store in self.__store_obj_list:
            # if the current store's id matches the given id
            # remove it from the store object list
            if store.get_store_id() == str_id:
                found = True  # we have found a matching store so change found to True

                # remove the current store from the store object list
                self.__store_obj_list.remove(store)

                # print that we have successfully removed store of given id
                print(f"Successfully removed store with store id: {str_id}")

                # break out from looping through the store obj list as we found the store of matching id
                # and removed it
                break

        # if after looping through the whole store object list we did not find a matching store
        # print that no store was found
        if not found:
            # print that no store matched the given id
            print("Store not found!")

    def add_new_store(self, s_nm, s_city, s_area):
        """
        Create a new Store object of given name, city, and area, and add it to __store_obj_list if it does not already exist.

        Parameters
        ----------
        s_nm : str
            The name of the store to be added.
        s_city : str
            The city of the store to be added.
        s_area : str
            The area(address) of the store to be added.

        Returns
        -------
        None
        """

        # create a new Store object with the given name, city, and area
        new_store = Store(s_nm, s_city, s_area)

        # if the newly created Store does not exist in the store object list append it to the list
        if self.store_exists(new_store) == -1:
            # append the new Store to the store object list
            self.__store_obj_list.append(new_store)

            # print that we have successfully added a new Store of given name
            print(f"Successfully added new {s_nm} store!!")

    def add_new_product(self, s_id, p_nm, p_sold, p_avl, p_cost, p_price):
        """
        Add a new product to a Store of given ID number given product name, number sold, number available, cost, and price.

        Parameters
        ----------
        s_id : int
            The ID number of the store to add the product too.
        p_nm : str
            The name of the product to be added.
        p_sold : int
            The number sold of the product to be added.
        p_avl : int
            The number available of the product to be added.
        p_cost : float
            The cost to purchase the product to be added.
        p_price : float
            The price of the product to be added.

        Returns
        -------
        None
        """

        found = False  # assume that the store of given id does not exist in the store object list to begin

        # loop through the store object list
        for store in self.__store_obj_list:
            # if the current store's id matches the given id
            # add a new product to the current store
            if store.get_store_id() == s_id:
                found = True  # we have found a matching store so change found to True

                # add the new product of given name, number sold, cost, and price
                store.add_product(p_nm, p_sold, p_avl, p_cost, p_price)

                # print that we have successfully added new the new product
                print("Successfully added new the new product!!")

                # break out from looping through the store obj list as we found the store of matching id
                # and added the new product
                break

        # if after looping through the whole store object list we did not find a matching store
        # print that no store was found and that we could not add the new product
        if not found:
            # print that no store matched the given id
            print("Store not found! Product can't be added")


def main():
    comp = storeDB("inventory.csv")
    print("******************************************************************************")
    comp.read_file()
    print("******************************************************************************")
    comp.add_store_products()
    print("******************************************************************************")
    # str_nm = input("Enter the store name that you want to search: ")
    comp.print_store_info("Walmart")
    print("******************************************************************************")
    # str_id = int(input("Enter the store ID for the product list: "))
    comp.print_product_info(29)
    print("******************************************************************************")
    # str_id = int(input("Enter the store ID of the store that you want to remove: "))
    comp.remove_store_data(996)
    print("******************************************************************************")
    comp.add_new_store('Walmart', 'Charlottetown', '1 abc st')
    print("******************************************************************************")
    comp.add_new_product(1001, 'Laptop', 300, 200, 2048.12, 2132.43)
    print("******************************************************************************")
    comp.print_store_info("Walmart")
    print("******************************************************************************")
    comp.print_product_info(1001)
    print("******************************************************************************")


if __name__ == "__main__":
    main()
