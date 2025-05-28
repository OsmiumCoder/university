import csv
import copy
from store import Store
import random
from stack import Stack


class StackStorage(object):
    """
    Class to create a stack data structure containing store objects that contain products.

    Attributes
    ----------
    dlist : list
        A list of lists containing the necessary store or product information.
    store_obj_stack : Stack
        A stack to contain store objects.

    Methods
    -------
    get_store_obj_stack():
        Return store_obj_stack.
    store_in_stack(str_id):
        Check if store of given id is within the stack.
    build_stack():
        Add unique stores to the store_obj_stack and products to their respective store.
    get_odd_even_store_stacks():
        Return two stacks, one containing all stores with an odd store id, and one containing all stores of even id.
    build_products_stack(slst):
        Return a stack containing all products in all stores of a given store id in the slst.
    """

    def __init__(self, dataList):
        """
        Construct a new instance of StackStorage with the necessary variables.

        Parameters
        ----------
        dataList : list
            A list of lists containing the necessary store or product information.
        """

        self.dlist = dataList.
        self.store_obj_stack = Stack()

    def get_store_obj_stack(self):
        """
        Return store_obj_stack.

        Returns
        -------
        store_obj_stack : Stack
            The stack containing store objects.
        """

        return self.store_obj_stack

    def store_in_stack(self, str_id):
        """
        Check if store of given id is within the stack.

        Parameters
        ----------
        str_id : str
            The store id to be searched for.

        Returns
        -------
        exists : bool
            True if the store of given id is already in the stack, False otherwise.
        """

        size = self.store_obj_stack.stack_size()  # get the size in order to pop from the stack without error
        temp_store_list = []  # temporary list of store objects to be pushed back to the stack after search
        exists = False  # variable for the existence of the store being checked

        # if the stack contains store objects
        # then we can loop through the stores in the stack
        if size is not None:
            # loop a maximum number of times equal to the number of store objects in the stack
            for i in range(0, size):
                # get a store from the stack
                store = self.store_obj_stack.pop_element()

                # append the current store to the temporary list so that it can be added back later
                temp_store_list.append(store)

                # if the current store's id matches the given store id
                # then we have found a match
                if store.get_store_id() == str_id:
                    exists = True
                    break  # break from the loop since a store was found

            # loop through the temporary store list and push them back to the stack
            # the list is reversed so to follow the stack rules first in last out
            # append adds to the right, so we need to start from the right
            for store in reversed(temp_store_list):
                # push the current store back to the stack
                self.store_obj_stack.push_element(store)

        return exists

    def build_stack(self):
        """
        Add unique stores to the store_obj_stack and products to their respective store.

        Returns
        -------
        None
        """

        # loop through the list of lists
        # creating a new store from a list
        # or adding a product to a store
        for data in self.dlist:
            # the first item of a list contains the id
            element_id = data[0]

            # if the element id starts with an S it signifies a store
            if element_id.startswith("S"):
                store_name = data[1]  # the second item in the list will be the store name
                store_city = data[2]  # the third item in the list will be the store city
                store_area = data[3]  # the fourth item in the list will be the store area(address)

                new_store = Store(element_id, store_name, store_city, store_area)

                # if the newly created store does not already exist in the stack
                # then push it to the stack
                if not self.store_in_stack(element_id):
                    # push the new store to the stack
                    self.store_obj_stack.push_element(new_store)

            # if the element id starts with a P it signifies a product
            elif element_id.startswith("P"):
                # since it is a product, the element id will be the product id and name separated by a hyphen
                prod_id_name = element_id.split("-")

                # the second item in the list will be the store id to which the product goes in
                prod_store_id = data[1]

                # the third item in the list will be the number sold and available of the product separated by a hyphen
                prod_sold_avail = data[2].split("-")

                # the fourth item in the list will be the cost and retail price of the product separated by a hyphen
                prod_cost_price = data[3].split("-")

                # if the products store id is in the stack
                # then add the product to its store
                if self.store_in_stack(prod_store_id):
                    size = self.store_obj_stack.stack_size()  # get the size in order to pop from the stack without error
                    temp_store_list = []  # temporary list of store objects to be pushed back to the stack after search

                    # if the stack contains store objects
                    # then we can loop through the stores in the stack
                    if size is not None:
                        # loop a maximum number of times equal to the number of store objects in the stack
                        for i in range(0, size):
                            # get a store from the stack
                            store = self.store_obj_stack.pop_element()

                            # append the current store to the temporary list so that it can be added back later
                            temp_store_list.append(store)

                            # if the current store's id matches the product's store id
                            # then add the new product to it
                            if store.get_store_id() == prod_store_id:
                                store.add_product(prod_id_name[0], prod_id_name[1], prod_sold_avail[0], prod_sold_avail[1], prod_cost_price[0], prod_cost_price[1])

                        # loop through the temporary store list and push them back to the stack
                        # the list is reversed so to follow the stack rules first in last out
                        # append adds to the right, so we need to start from the right
                        for store in reversed(temp_store_list):
                            # push the current store back to the stack
                            self.store_obj_stack.push_element(store)

                # if the products store id is not in the stack
                # then print that no store exists that matches the products store id
                else:
                    print(f"Store ID {prod_store_id} does not exist! Adding Product is not possible!")

        # print the number of unique stores that have been added to the stack
        print(f"Constructor added {self.store_obj_stack.stack_size()} store objects to the stack store_obj_stack!")

    def get_odd_even_store_stacks(self):
        """
        Return two stacks, one containing all stores with an odd store id, and one containing all stores of even id.

        Returns
        -------
        odd_stack : Stack
            A Stack containing all the stores with an odd id number.
        even_stack : Stack
            A Stack containing all the stores with an even id number.
        """

        odd_stack = Stack()  # stack for stores of odd id
        even_stack = Stack()  # stack for stores of even id
        size = self.store_obj_stack.stack_size()  # get the size in order to pop from the stack without error
        temp_store_list = []  # temporary list of store objects to be pushed back to the stack after search

        # if the stack contains store objects
        # then we can loop through the stores in the stack
        if size is not None:
            # loop a maximum number of times equal to the number of store objects in the stack
            for i in range(0, size):
                # get a store from the stack
                store = self.store_obj_stack.pop_element()

                # append the current store to the temporary list so that it can be added back later
                temp_store_list.append(store)

                # get the current stores id
                store_id = store.get_store_id()

                # slice the current store's id removing the S at the front
                # the remainder is an integer in string format so convert
                store_id_int = int(store_id[1:])

                # if the store id number is evenly divisible by 2 its remainder will be 0 proving evenness
                if store_id_int % 2 == 0:
                    # push the store to the even stack
                    even_stack.push_element(store)

                # if the store id number is not evenly divisible by 2 its remainder will be 1 proving oddness
                else:
                    # push the store to the even stack
                    odd_stack.push_element(store)

            # loop through the temporary store list and push them back to the stack
            # the list is reversed so to follow the stack rules first in last out
            # append adds to the right, so we need to start from the right
            for store in reversed(temp_store_list):
                # push the current store back to the stack
                self.store_obj_stack.push_element(store)

        return odd_stack, even_stack

    def build_products_stack(self, slst):
        """
        Return a stack containing all products in all stores of a given store id in the slst.

        Parameters
        ----------
        slst : list
            A list containing store id's for which to prin the products of.

        Returns
        -------
        prod_stack : Stack
            A stack containing all the product objects in all the stores whose id is in the slst list.
        """

        prod_stack = Stack()  # stack for the products in matching stores
        size = self.store_obj_stack.stack_size()  # get the size in order to pop from the stack without error
        temp_store_list = []  # temporary list of store objects to be pushed back to the stack after search

        # if the stack contains store objects
        # then we can loop through the stores in the stack
        if size is not None:
            # loop a maximum number of times equal to the number of store objects in the stack
            for i in range(0, size):
                # get a store from the stack
                store = self.store_obj_stack.pop_element()

                # append the current store to the temporary list so that it can be added back later
                temp_store_list.append(store)

                # if the current store's id is in the list of given store id's
                # then get all the products from that store and add them to the stack
                if store.get_store_id() in slst:
                    # get the product dictionary from the matching store
                    prod_dict = store.get_products()

                    # loop through the returned dictionaries values which are product objects
                    # and push them to the stack of products
                    for prod in prod_dict.values():
                        # push the current product to the stack
                        prod_stack.push_element(prod)

            # loop through the temporary store list and push them back to the stack
            # the list is reversed so to follow the stack rules first in last out
            # append adds to the right, so we need to start from the right
            for store in reversed(temp_store_list):
                # push the current store back to the stack
                self.store_obj_stack.push_element(store)

        return prod_stack


def main():
    data = []
    with open('asn4Inventory.csv', encoding="utf-8-sig", newline='') as csv_file:
        reader = csv.reader(csv_file)
        flag = 0
        for row in reader:
            if flag == 0:
                flag = 1
                continue
            data.append(row)
    stackObj = StackStorage(data)
    print("******************************************************************************")
    print("Printing Stack of Store objects:")
    stk = stackObj.get_store_obj_stack()
    stk.print_stack(0)
    print("******************************************************************************")
    print("Building Stack of Store objects...")
    stackObj.build_stack()
    print("******************************************************************************")
    print("Printing Stack of Store objects:")
    stk = stackObj.get_store_obj_stack()
    stk.print_stack(0)
    print("******************************************************************************")
    oddStk, evenStk = stackObj.get_odd_even_store_stacks()
    print("Printing Stack of Store objects with odd store ids:")
    oddStk.print_stack(1)
    print("******************************************************************************")
    print("Printing Stack of Store objects with even store ids:")
    evenStk.print_stack(1)
    print("******************************************************************************")
    slst = ["S1001", "S1002", "S1003", "S1004", "S1005", "S1006", "S1007", "S1008", "S1009", "S10101", "S10111"]
    vlst = random.sample(slst, 5)
    vlst.sort(reverse=True)
    pstk = stackObj.build_products_stack(vlst)
    print(f"Printing stack of products for a given list of store ids:")
    print("Store ids:", vlst)
    pstk.print_stack(1)
    print("******************************************************************************")
    print("Printing to check if the Original Stack of Store objects is intact:")
    stk = stackObj.get_store_obj_stack()
    stk.print_stack(0)
    print("******************************************************************************")


if __name__ == "__main__":
    main()
