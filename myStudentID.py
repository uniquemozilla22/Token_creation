from brownie import myStudentId

def main():
    student_id = 12345 # Replace with your desired student ID
    my_student_id = myStudentId.deploy(student_id, {'from': accounts[0]})