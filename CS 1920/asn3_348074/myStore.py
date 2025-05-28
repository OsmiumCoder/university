import csv
import copy
from store import Store
from random import randint


class MyStore(Store):
    """
    Class to create data base of unique stores and unique products.

    Methods
    -------
    print_stores():
        Print the representative information of each logged store.
    print_prod_id_mapping():
        Print each unique logged product id.
    print_product_in(pid):
        Print the products of matching product id in any store that contains the matching product.
    add_new_store(sID, sName, sCity, sAddress):
        Add a new store to the data base of logged stores if it does not already exist.
    add_new_product(sID, pID, pName, pSold, pAvl, pCost, pPrice):
        Add a new product to a given store if it exists.
    delete_store(sID):
        Delete a store of matching id if it exists.
    """

    store_obj_list = {}  # A dictionary of key equal to store id and value equal to Store object instance
    product_id_mapping = {}  # A dictionary of key equal to input product id and value equal to matching system generated ID

    def __init__(self, dataList):
        """
        Construct new instance of MyStore.

        Parameters
        ----------
        dataList : list
            A list of lists which contain all the necessary information for a store or a product.
        """

        # iterate through the list of lists
        # info will be a list containing the information for a store or product
        for info in dataList:
            record_id = info[0]  # record id will tell if it is a store or product

            # if the record id starts with a S the info will represent a store
            if record_id.startswith("S"):
                str_name = info[1]  # the second item of info is the stores name
                str_city = info[2]  # the third item of info is the stores city
                str_area = info[3]  # the fourth item of info is the stores area

                # if the record id which represents a store is not already a key of the store dictionary
                # then create a new store and add it to the store dictionary
                if record_id not in MyStore.store_obj_list:
                    # create instance of a Store object using the super class Store
                    new_store = super().__init__(record_id, str_name, str_city, str_area)

                    # make a new dictionary entry with key equal to the stores record id
                    # and value of a deep copy of the just created store
                    MyStore.store_obj_list[record_id] = copy.deepcopy(new_store)

            # if our record id starts with a P info will represent a product
            elif record_id.startswith("P"):
                p_id_name = info[0].split("-")  # product id and name are separated by a hyphen, splitting results in list: [id, name]
                str_id = info[1]  # the store id is on its own as info's second item
                p_sold_available = info[2].split("-")  # products sold and available are separated by a hyphen, splitting results in list: [sold, available]
                p_cost_price = info[3].split("-")  # product cost and price are separated by a hyphen, splitting results in list: [cost, price]

                # if the given store id is a key in our store dictionary
                # then we can add a product to the store of matching id
                if str_id in MyStore.store_obj_list:
                    # the matching store is the value of the store dictionary at the given store id
                    matching_store = MyStore.store_obj_list[str_id]

                    # if the given product id is not a key in the product id mapping dictionary
                    # then add a brand new unique product to the the matching store
                    if p_id_name[0] not in MyStore.product_id_mapping:
                        # add the new product to the matching store
                        # pass missing as the id to get a new system generated id
                        matching_store.add_product("Missing", p_id_name[1], int(p_sold_available[0]), int(p_sold_available[1]), float(p_cost_price[0]), float(p_cost_price[1]))

                        # get the keys of the matching stores product dictionary
                        # and turn into list to access most recent addition
                        matching_store_p_keys = list(matching_store.get_products().keys())

                        # the generated id of the unique new product that was just added is the last
                        # key of the matching stores product keys
                        generated_id = matching_store_p_keys[-1]

                        # map the new unique product to the product id mapping dictionary
                        # with key equal to the input product id and value equal to its unique system generated id
                        MyStore.product_id_mapping[p_id_name[0]] = generated_id

                    # if the given product id is a key in the product id mapping dictionary
                    # then add a new product to the the matching store with the existing system generated id for the given product id
                    else:
                        # the existing system generated id is the value of the product id mapping dictionary
                        # at key equal to the given product id
                        existing_id = MyStore.product_id_mapping[p_id_name[0]]

                        # add the new product to the matching store
                        # pass the existing id as the id as we do not need the system to generate a new one
                        matching_store.add_product(existing_id, p_id_name[1], int(p_sold_available[0]), int(p_sold_available[1]), float(p_cost_price[0]), float(p_cost_price[1]))

                # if the given store id is not a key in our store dictionary
                else:
                    # print that the store does not exist so we can not add a product
                    print(f"Store ID {str_id} does not exist! Adding Product is not possible!")

        # after all stores and products have been created and added print how many unique stores were created with there products added
        print(f"Constructor added {len(MyStore.store_obj_list)} matching store objects to the dictionary store_obj_list!")

    def print_stores(self):
        """
        Print the representative information of each logged store.

        Returns
        -------
        None
        """

        # iterate through the store dictionary values
        for store in MyStore.store_obj_list.values():
            # print the __str__ of each store object
            print(store)

    def print_prod_id_mapping(self):
        """
        Print each unique logged product id.

        Returns
        -------
        None
        """

        # iterate through the product id mapping dictionary keys and values
        for input_id, sys_gen_id in MyStore.product_id_mapping.items():
            # print each input id and its system generated id
            print(f"InputID:{input_id}, SystemGeneratedID:{sys_gen_id}")

    def print_product_in(self, pid):
        """
        Print the products of matching product id in any store that contains the matching product.

        Parameters
        ----------
        pid : str
            The input product id used to find and print all products that match in any logged store.

        Returns
        -------
        None
        """

        # if the given product id is in the product id mapping dictionary
        # then print the products of matching id if it is in any store
        if pid in MyStore.product_id_mapping:
            # get the system generated id that is equivalent to the given id
            sys_generated_id = MyStore.product_id_mapping[pid]

            # print the given id and its mapped system generated id
            print(f"Input PID:{pid} is mapped to SystemGeneratedID:{sys_generated_id}..start printing..")

            # iterate through the store dictionary keys and values
            for s_id, store in MyStore.store_obj_list.items():
                # iterate through the current store's product inventory dictionary keys and values
                for p_id, product in store.get_products().items():
                    # if the current product id matches the given id's system generated id
                    # then print the current store's id and the matching product
                    if p_id == sys_generated_id:
                        # print the current store id and the __str__ of the matching product
                        print(f"Store ID:{s_id}, {product}")

        # if the given product id is not in the product id mapping dictionary
        # then print the given product id does not exist
        else:
            print(f"{pid} does not exist in the database!")

    def add_new_store(self, sID, sName, sCity, sAddress):
        """
        Add a new store to the data base of logged stores if it does not already exist.

        Parameters
        ----------
        sID : str
            The id of the new store.
        sName : str
            The name of the new store.
        sCity : str
            The City the new store is in.
        sAddress : str
            The address(area) of the new store.

        Returns
        -------
        None
        """

        # if the given store id is not in the store dictionary
        # then create a new store and add it to the dictionary
        if sID not in MyStore.store_obj_list:
            # create instance of a Store object using the super class Store
            new_store = super().__init__(sID, sName, sCity, sAddress)

            # make a new dictionary entry with key equal to the given id
            # and value of a deep copy of the just created store
            MyStore.store_obj_list[sID] = copy.deepcopy(new_store)

            # print the store of given id has been created and added to the store dictionary
            print(f"New store object with store id {sID} successfully added to the database!")
            # print the new number of stores in the store dictionary
            print(f"Updated dictionary store_obj_list size: {len(MyStore.store_obj_list)}")

        # if the given store id is in the store dictionary
        # then print store of given id already exists
        else:
            print(f"Store with store id {sID} already exists!")

    def add_new_product(self, sID, pID, pName, pSold, pAvl, pCost, pPrice):
        """
        Add a new product to a given store if the store exists.

        Parameters
        ----------
        sID : str
            The ID of the store to add the product to.
        pID : str
            The ID of the product to be added.
        pName : str
            The name of the product to be added.
        pSold : int
            The amount sold of the product.
        pAvl : int
            The amount available of the product.
        pCost : float
            The cost of the product.
        pPrice : float
            The price of the product.

        Returns
        -------
        None
        """

        # if the store of given id is in the store dictionary
        # then add a new product to it
        if sID in MyStore.store_obj_list:
            # the matching store is the value of the store dictionary at the given store id
            matching_store = MyStore.store_obj_list[sID]

            # if the given product id is not a key in the product id mapping dictionary
            # then add a brand new unique product to the the matching store
            if pID not in MyStore.product_id_mapping:
                # add the new product to the matching store
                # pass missing as the id to get a new system generated id
                matching_store.add_product("Missing", pName, pSold, pAvl, pCost, pPrice)

                # get the keys of the matching stores product dictionary
                # and turn into list to access most recent addition
                matching_store_p_keys = list(matching_store.get_products().keys())

                # the generated id of the unique new product that was just added is the last
                # key of the matching stores product keys
                generated_id = matching_store_p_keys[-1]

                # map the new unique product to the product id mapping dictionary
                # with key equal to the input product id and value equal to its unique system generated id
                MyStore.product_id_mapping[pID] = generated_id

            # if the given product id is a key in the product id mapping dictionary
            # then add a new product to the the matching store with the existing system generated id for the given product id
            else:
                # the existing system generated id is the value of the product id mapping dictionary
                # at key equal to the given product id
                existing_id = MyStore.product_id_mapping[pID]

                # add the new product to the matching store
                # pass the existing id as the id as we do not need the system to generate a new one
                matching_store.add_product(existing_id, pName, pSold, pAvl, pCost, pPrice)

        # if the store of given id is not in the store dictionary
        # then print the store of given id does not exist
        else:
            print(f"Store ID {sID} does not exist! Adding Product is not possible!")

    def delete_store(self, sID):
        """
        Delete a store of matching id if it exists.

        Parameters
        ----------
        sID : str
            The id of the store to be deleted.

        Returns
        -------
        None
        """

        # if the given store id is in the store dictionary
        # then delete that matching key value pair
        if sID in MyStore.store_obj_list:
            # delete the key value pair where key is equal to the given store id
            del MyStore.store_obj_list[sID]
            # print the store of given store id has been deleted
            print(f"Successfully deleted store with Store ID {sID}.")

        # if the given store id is not in the store dictionary
        # then print the store of given id does not exist
        else:
            print(f"Store ID {sID} does not exist! Deletion is not possible!")


def main():
    data = []
    with open('storeInventory.csv', encoding="utf-8-sig", newline='') as csv_file:
        reader = csv.reader(csv_file)
        flag = 0
        for row in reader:
            if flag == 0:
                flag = 1
                continue
            data.append(row)
    storeObj = MyStore(data)
    print("******************************************************************************")
    print("Printing Store objects:")
    storeObj.print_stores()
    print("******************************************************************************")
    print("Printing ProductID mapping:")
    storeObj.print_prod_id_mapping()
    print("******************************************************************************")
    plst = ["P2001", "P2002", "P2003", "P2004", "P2005", "P2006", "P2007", "P2008", "P2009", "P2010"]
    val = randint(0, 9)
    print(f"Printing all-stores inventory of Product ID {plst[val]}:")
    storeObj.print_product_in(plst[val])
    print("******************************************************************************")
    storeObj.add_new_store("S1011", "MnMPlaza", "Stratford", "123 ABC Parkway")
    storeObj.add_new_store("S1003", "CityPlaza", "Jiukeng", "634 Jackson Parkway")
    print("******************************************************************************")
    storeObj.add_new_product("S1020", "P2015", "Chair", 1234, 324, 523.45, 432.12)
    storeObj.add_new_product("S1001", "P2015", "Chair", 1234, 324, 523.45, 432.12)
    print("Updated ProductID mapping:")
    storeObj.print_prod_id_mapping()
    print("******************************************************************************")
    storeObj.delete_store("S1080")
    storeObj.delete_store("S1009")
    print("Updated Store objects dictionary:")
    storeObj.print_stores()
    print("******************************************************************************")


if __name__ == "__main__":
    main()
