-- Create the Patient table
CREATE TABLE IF NOT EXISTS Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    DateOfBirth DATE,
    Phone VARCHAR(50),
    Postcode VARCHAR(20)
);

-- Create the Staff table
CREATE TABLE IF NOT EXISTS Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(50)
);

-- Create the Appointment table
CREATE TABLE IF NOT EXISTS Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    StaffID INT,
    AppointmentDateTime DATETIME NOT NULL,
    Status VARCHAR(50) DEFAULT 'Scheduled',
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Create the EyeExam table
CREATE TABLE IF NOT EXISTS EyeExam (
    ExamID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    PatientID INT NOT NULL,
    OptometristID INT NOT NULL,
    ExamDate DATE NOT NULL,
    RightEyeSphere VARCHAR(10),
    RightEyeCylinder VARCHAR(10),
    RightEyeAxis VARCHAR(10),
    RightEyeVisualAcuity VARCHAR(20),
    LeftEyeSphere VARCHAR(10),
    LeftEyeCylinder VARCHAR(10),
    LeftEyeAxis VARCHAR(10),
    LeftEyeVisualAcuity VARCHAR(20),
    EyeHealthNotes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (OptometristID) REFERENCES Staff(StaffID)
);

-- Create the Prescription table
CREATE TABLE IF NOT EXISTS Prescription (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    ExamID INT NOT NULL,
    IssueDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    RightEyeSphere VARCHAR(10),
    RightEyeCylinder VARCHAR(10),
    RightEyeAxis VARCHAR(10),
    RightEyeAdd VARCHAR(10),
    LeftEyeSphere VARCHAR(10),
    LeftEyeCylinder VARCHAR(10),
    LeftEyeAxis VARCHAR(10),
    LeftEyeAdd VARCHAR(10),
    PD VARCHAR(10),
    PrescriptionType VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (ExamID) REFERENCES EyeExam(ExamID)
);

-- Create the Product table
CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductCode VARCHAR(50) UNIQUE NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    ProductType VARCHAR(100) NOT NULL,
    Brand VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0
);

-- Create the Order table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    StaffID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Create the OrderItem table
CREATE TABLE IF NOT EXISTS OrderItem (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    PrescriptionID INT,
    Quantity INT NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    LineTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID)
);
