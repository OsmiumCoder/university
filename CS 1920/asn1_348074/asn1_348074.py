class DiceSet:
    """
    Class to create a dice set object.

    Attributes
    ----------
    __name : str
        The name of the dice set.
    __amount_of_dice : int
        The number of dice in the set.
    __price : float
        The price of the set.
    __description : string
        A brief description about the dice set.

    Methods
    -------
    get_next_id():
        Static method to track id for object instance.
    set_id(new_id):
        Sets id of DiceSet instance.
    set_name(new_name):
        Sets name of DiceSet instance.
    set_price(new_price):
        Sets price of DiceSet instance.
    set_amount_of_dice(new_amount):
        Sets amount of dice of DiceSet instance.
    set_desc(new_desc):
        Sets description of DiceSet instance.
    get_id():
        Returns id of DiceSet instance.
    get_name():
        Returns name of DiceSet instance.
    get_price():
        Returns price of DiceSet instance.
    get_amount_of_dice():
        Returns amount of dice of DiceSet instance.
    get_desc():
        Returns description of DiceSet instance.
    __str__
        Returns formatted string of all instance variables.
    """

    # static variable to track number of instances to give unique id
    identifier = 0

    # CONSTRUCTOR FUNCTION
    def __init__(self, name, amount_of_dice, price, desc):
        """
        Constructs all the necessary attributes for the DiceSet object.

        Parameters
        ----------
        name : str
            Name of the dice set.
        amount_of_dice : int
            Amount of dice in a set.
        price : float
            Price of the dice set.
        desc : str
            Description of the dice set.
        """

        self.__id = self.get_next_id()
        self.__name = name
        self.__amount_of_dice = amount_of_dice
        self.__price = price
        self.__desc = desc

    @staticmethod
    def get_next_id():
        """
        Returns the id number for a new instance of DiceSet.

        Returns
        -------
        DiceSet.identifier : int
            The current DiceSet.identifier plus one.
        """

        DiceSet.identifier += 1  # increase the instance counter by 1 to track id number of instances
        return DiceSet.identifier

    # SETTERS
    def set_id(self, new_id):
        """
        Sets id of DiceSet instance.

        Parameters
        ----------
        new_id : int
            New id number for DiceSet instance.

        Returns
        -------
        None
        """

        self.__id = new_id

    def set_name(self, new_name):
        """
        Sets name of DiceSet instance.

        Parameters
        ----------
        new_name : str
            New name string for DiceSet instance.

        Returns
        -------
        None
        """

        self.__name = new_name

    def set_amount_of_dice(self, new_amount):
        """
        Sets amount of dice of DiceSet instance.

        Parameters
        ----------
        new_amount : int
            New amount for DiceSet instance.

        Returns
        -------
        None
        """

        self.__amount_of_dice = new_amount

    def set_price(self, new_price):
        """
        Sets price of DiceSet instance.

        Parameters
        ----------
        new_price : float
            New price for DiceSet instance.

        Returns
        -------
        Changed : bool
            True if new price was set, False otherwise.
        """

        changed = False

        # only change the price if the new price is between 12.99 and 84.99
        if 12.99 <= new_price <= 84.99:
            self.__price = new_price
            changed = True

        return changed

    def set_desc(self, new_desc):
        """
        Sets description of DiceSet instance.

        Parameters
        ----------
        new_desc : str
            New description for DiceSet instance.

        Returns
        -------
        None
        """

        self.__desc = new_desc

    # GETTERS
    def get_id(self):
        """
        Return id of DiceSet instance.

        Returns
        -------
        __id : int
            The id of the DiceSet.
        """

        return self.__id

    def get_name(self):
        """
        Return name of DiceSet instance.

        Returns
        -------
        __name : str
            The name of the DiceSet.
        """

        return self.__name

    def get_amount_of_dice(self):
        """
        Return the amount of dice of DiceSet instance.

        Returns
        -------
        __amount_of_dice : int
            The amount of dice of the DiceSet.
        """

        return self.__amount_of_dice

    def get_price(self):
        """
        Return the price of the DiceSet instance.

        Returns
        -------
        __price : float
            The price of the DiceSet instance.
        """

        return self.__price

    def get_desc(self):
        """
        Return the description of the DiceSet instance.

        Returns
        -------
        __desc : str
            The description of the DiceSet instance.
        """

        return self.__desc

    def __str__(self):
        """
        Return the formatted string of all instance variables of the DiceSet instance.

        Returns
        -------
        str
            The formatted string of all instance variables of the Dice set instance.
        """

        return "ID: " + str(self.__id) + "; Dice Set Name: " + self.__name + "; Number of Dice in Set: " + str(self.__amount_of_dice) + "; Price: " + str(self.__price) + "; Description: " + self.__desc


def main():
    """
    Main function of program to execute all tasks.

    Returns
    -------
    None
    """

    # CREATE OBJECTS FROM CSV
    sets = []  # list of DiceSet objects

    # read file and create DiceSet object from each line then close file
    with open("asn1_348074_products.csv") as file:
        next(file)  # skip first line of file to skip header information

        # loop through each line of file and create new DiceSet object
        for line in file:
            # split each line delimited by commas and strip each value of whitespace
            data = [x.strip() for x in line.split(",")]
            # create a new DiceSet from the line data
            new = DiceSet(data[0], int(data[1]), float(data[2]), data[3])
            # append the object instance to the list of DiceSets
            sets.append(new)

    # PRINT OUT __STR__ FOR EACH OBJECT
    # loop through list of DiceSets
    for dice in sets:
        # print the objects __str__
        print(dice)

    # CHANGE STRING ATTRIBUTE OF THE FIRST PRODUCT
    first = sets[0]  # first DiceSet from list of DiceSets
    name = first.get_name()  # get the current name of DiceSet 1
    print("Dice set name of product 1: " + name)  # print the current name of DiceSet 1

    print("Updating string attribute value ...")
    first.set_name("Galaxy Magenta")  # change the name of DiceSet 1
    changed_name = first.get_name()  # get the changed name of DiceSet 1
    print("Updated dice set name of product 1: " + changed_name)  # print the changed name of DiceSet 1

    # CHANGE THE INTEGER ATTRIBUTE OF THE SECOND PRODUCT
    second = sets[1]  # second DiceSet from the list of DiceSets
    set_size = second.get_amount_of_dice()  # get the current amount of dice of DiceSet 2
    print("Number of dice in set of product 2: " + str(set_size))  # print the current amount of dice of DiceSet 2

    print("Updating integer attribute value ...")
    second.set_amount_of_dice(7)  # change the amount of dice of DiceSet 2
    changed_size = second.get_amount_of_dice()  # get the changed amount of dice of DiceSet 2
    print("Number of dice in set of product 2: " + str(changed_size))  # print the changed amount of dice of DiceSet 2

    # CHANGE THE FLOAT ATTRIBUTE OF THE THIRD PRODUCT
    third = sets[2]  # third DiceSet from list of DiceSets
    price = third.get_price()  # get the current price of DiceSet 3
    print("Dice set price of product 3: " + str(price))  # print the current price of DiceSet 3

    # illegal value
    print("Updating float attribute with illegal value ...")
    change_price = third.set_price(99.99)  # change the price of DiceSet 3 with a value not in the set range
    changed_price = third.get_price()  # get the new price of DiceSet 3
    print("Update of float attribute: " + str(change_price))  # print the bool returned from set_price True if changed, False otherwise
    print("Dice set price of product 3: " + str(changed_price))  # print the changed price of DiceSet 3

    # legal value
    print("Updating float attribute with legal value ...")
    change_price2 = third.set_price(19.99)  # change the price of DiceSet 3 with a value in the set range
    new_price2 = third.get_price()  # get the new price of DiceSet 3
    print("Update of float attribute: " + str(change_price2))  # print the bool returned from set_price True if changed, False otherwise
    print("Dice set price of product 3: " + str(new_price2))   # print the changed price of DiceSet 3

    # WRITE CHANGED PRODUCTS TO NEW CSV
    # create new file to be written in then closed
    with open("asn1_348074_updated_products.csv", 'w') as new_file:
        # write header line which now includes id of DiceSet instance
        new_file.write("Unique_ID,Name,Amount_of_Dice,Price,Description\n")

        # loop through each DiceSet in list of DiceSets and write data to csv
        for dice in sets:
            # get all instance attributes
            id_num = dice.get_id()
            name = dice.get_name()
            amount_of_dice = dice.get_amount_of_dice()
            price = dice.get_price()
            description = dice.get_desc()

            # create a list to be joined as a line
            line = [id_num, name, amount_of_dice, price, description]
            # convert all items to strings before joining the items of the line list with a comma
            new_line = ",".join(str(x) for x in line)
            # write the new line to the updated products csv
            new_file.write(new_line + "\n")


# execute main function if __name__ is __main__
if __name__ == "__main__":
    main()
